program cajero;

uses crt;

type
	clientes = record
		cedula:string;
		nombre:string;
		apellido:string;
		saldo:real;
	end;

var 
	usuario, beneficiario: clientes;
	lista_clientes, borrador, respaldo_lista, respaldo_lista2: text;
	caracter: char='x';
	linea, dinero, cedu_archivo, cedu_usuario, cedu_beneficiario, salto: string;
	ope, ope_dep, ope_ini, ope_monto: string;
	i,x,y: integer;
	monto: real;

BEGIN
	Assign(lista_clientes, 'clientes.txt');
	Assign(borrador, 'borrador.txt');
	Assign(respaldo_lista, 'respaldo_clientes.txt');
	Assign(respaldo_lista2, 'respaldo_clientes2.txt');
	x:=0;
	y:=0;
	i:=1;
	ReSet(lista_clientes);
	while not EOF(lista_clientes) do
	begin
		x:=x+1;
		readln(lista_clientes);
	end;
	Close(lista_clientes);
	
	gotoxy(32,10);
	writeln('CAJERO AUTOMATICO "BANESCO"');	
	gotoxy(30,12);
	writeln('PRESIONE CUALQUIER TECLA PARA INGRESAR  .  .  .');
	gotoxy(76,12);
	readkey;
	
	repeat
		clrscr;
		gotoxy(38,6);
		writeln('QUE DESEA HACER?');
		gotoxy(33,8);
		writeln('1.-INGRESAR AL CAJERO');
		gotoxy(33,9);
		writeln('2.-SALIR');
		gotoxy(33,11);
		writeln('OPCION: ');
		gotoxy(41,11);
		readln(ope_ini);
		
		case ope_ini of
		
			'1': {INGRESAR AL CAJERO}
			begin
				clrscr;
				ReWrite(borrador);
				Close(borrador);
				ReWrite(respaldo_lista);
				Close(respaldo_lista);
				ReSet(lista_clientes);
				
				gotoxy(22,6);
				write('INGRESE SU NUMERO DE CEDULA (SIN PUNTOS): ');
				gotoxy(64,6);
				readln(cedu_usuario);
				
				while not EOF(lista_clientes) do
				begin
					while not EOLN(lista_clientes) do
					begin
						while caracter <> '/' do
						begin
							read(lista_clientes, caracter);
							if caracter <> '/' then
							begin
								Append(borrador);
								write(borrador, caracter);
								Close(borrador);
							end;
						end;
						ReSet(borrador);
						read(borrador, linea);
						if i = 1 then
							cedu_archivo:=linea;
						
						if cedu_archivo = cedu_usuario then
						begin
							salto:='omitir';
							case i of
							
								1:
								begin
									usuario.cedula:=linea;
								end;
								
								2:
								begin
									usuario.nombre:=linea;
								end;
								
								3:
								begin
									usuario.apellido:=linea;
								end;
								
								4:
								begin
									val(linea, usuario.saldo);
								end;
							end;
						end
						else
						begin
							salto:='saltar';
							Append(respaldo_lista);
							write(respaldo_lista, linea+'/');
							Close(respaldo_lista);
						end;
						Close(borrador);
						ReWrite(borrador);
						Close(borrador);
						i:=i+1;
						caracter:='x';
					end;
					
					readln(lista_clientes);
					if (y=x-1) then
						salto:='omitir';
					
					case salto of
					
						'saltar':
						begin
							Append(respaldo_lista);
							writeln(respaldo_lista);
							Close(respaldo_lista);
						end;
						
						'omitir':
						begin
						end;
					end;
					i:=1;
					y:=y+1;
				end;
				Close(lista_clientes);
				
				if cedu_usuario=usuario.cedula then
				begin
					repeat
						clrscr;
						gotoxy(38,6);
						writeln('BIENVENIDO: Sr(a): '+usuario.nombre+' '+usuario.apellido+'. SELECCIONE LA OPERACION:');
						gotoxy(33,8);
						writeln('1.-DEPOSITO');
						gotoxy(33,9);
						writeln('2.-RETIRO');
						gotoxy(33,10);
						writeln('3.-CONSULTA DE SALDO');
						gotoxy(33,11);
						writeln('4.-HISTORICO DE OPERACIONES');
						gotoxy(33,12);
						writeln('5.-SALIR');
						gotoxy(33,14);
						writeln('OPCION: ');
						gotoxy(41,14);
						readln(ope);
						
						case ope of 
						
							'1': {DEPOSITO}
							begin
								repeat
									clrscr;
									gotoxy(38,6);
									writeln('SELECCIONE EL TIPO DE CUENTA');
									gotoxy(33,8);
									writeln('1.-CUENTA PROPIA');
									gotoxy(33,9);
									writeln('2.-CUENTA DE TERCEROS EN MISMO BANCO');
									gotoxy(33,10);
									writeln('3.-REGRESAR');
									gotoxy(33,12);
									writeln('OPCION: ');
									gotoxy(41,12);
									readln(ope_dep);
									
									case ope_dep of
										
										'1': {CUENTA PROPIA}
										begin
											clrscr;
											gotoxy(33,10);
											writeln('INGRESE EL MONTO: ');
											gotoxy(51,10);
											readln(monto);
											usuario.saldo := usuario.saldo+monto;
											gotoxy(33,12);
											write('DEPOSITO REALIZADO EXITOSAMENTE!');
											gotoxy(33,14);
											write('Presione una tecla para continuar . . .');
											gotoxy(72,14);
											readkey;
											
											ope_dep := '3';
										end;
										
										'2': {CUENTA DE TERCEROS}
										begin
											clrscr;
											x:=0;
											y:=0;
											i:=1;
											ReSet(respaldo_lista);
											while not EOF(respaldo_lista) do
											begin
												x:=x+1;
												readln(respaldo_lista);
											end;
											Close(respaldo_lista);
											ReWrite(borrador);
											Close(borrador);
											ReWrite(respaldo_lista2);
											Close(respaldo_lista2);
											ReSet(respaldo_lista);
											
											gotoxy(33,10);
											writeln('INGRESE LA CEDULA DEL BENEFICIARIO (SIN PUNTOS): ');
											gotoxy(82,10);
											readln(cedu_beneficiario);
											
											while not EOF(respaldo_lista) do
											begin
												while not EOLN(respaldo_lista) do
												begin
													while caracter <> '/' do
													begin
														read(respaldo_lista, caracter);
														if caracter <> '/' then
														begin
															Append(borrador);
															write(borrador, caracter);
															Close(borrador);
														end;
													end;
													ReSet(borrador);
													read(borrador, linea);
													if i = 1 then
														cedu_archivo:=linea;
													
													if cedu_archivo = cedu_beneficiario then
													begin
														salto:='omitir';
														case i of
														
															1:
															begin
																beneficiario.cedula:=linea;
															end;
															
															2:
															begin
																beneficiario.nombre:=linea;
															end;
															
															3:
															begin
																beneficiario.apellido:=linea;
															end;
															
															4:
															begin
																val(linea, beneficiario.saldo);
															end;
														end;
													end
													else
													begin
														salto:='saltar';
														Append(respaldo_lista2);
														write(respaldo_lista2, linea+'/');
														Close(respaldo_lista2);
													end;
													Close(borrador);
													ReWrite(borrador);
													Close(borrador);
													i:=i+1;
													caracter:='x';
												end;
												
												readln(respaldo_lista);
												if (y=x-1) then
													salto:='omitir';
												
												case salto of
												
													'saltar':
													begin
														Append(respaldo_lista2);
														writeln(respaldo_lista2);
														Close(respaldo_lista2);
													end;
													
													'omitir':
													begin
													end;
												end;
												i:=1;
												y:=y+1;
											end;
											Close(respaldo_lista);
											
											if cedu_beneficiario = beneficiario.cedula then
											begin
												gotoxy(33,12);
												writeln('INGRESE EL MONTO: ');
												gotoxy(51,12);
												readln(monto);
												
												if usuario.saldo > monto then
												begin
													usuario.saldo := usuario.saldo - monto;
													beneficiario.saldo := beneficiario.saldo + monto;
													str(beneficiario.saldo:0:2,dinero);
													ReSet(respaldo_lista2);
													ReWrite(respaldo_lista);
													writeln(respaldo_lista, beneficiario.cedula+'/'
														+beneficiario.nombre+'/'+beneficiario.apellido+'/'+dinero+'/');
													while not EOF(respaldo_lista2) do
													begin
														read(respaldo_lista2, caracter);
														write(respaldo_lista, caracter);
													end;
													Close(respaldo_lista);
													Close(respaldo_lista2);
													
													gotoxy(33,14);
													write('DEPOSITO REALIZADO EXITOSAMENTE!');
													gotoxy(33,16);
													write('Presione una tecla para continuar . . .');
													gotoxy(72,16);
													readkey;
													
													ope_dep := '3';
												end
												else
												begin
													gotoxy(33,14);
													writeln('SALDO INSUFICIENTE. . .');
													gotoxy(56,16);
													readkey;
												end;
											end
											else
											begin
												gotoxy(33,14);
												writeln('ESTA CEDULA NO ESTA REGISTRADA . . .');
												gotoxy(69,16);
												readkey;
											end;
											
										end;
										
										'3': {REGRESAR}
										begin
										end;
									
										else {Mensaje de error}
										begin
											gotoxy(31,17);
											writeln('Ingrese una opcion correcta . . .');
											gotoxy(76,17);
											readkey;
											clrscr;
										end;
									end;
								until (ope_dep='3');
							end;
							
							'2': {RETIRO}
							begin
								repeat
									clrscr;
									gotoxy(38,6);
									writeln('SELECCIONE EL MONTO');
									gotoxy(33,8);
									writeln('1.-1.000 Bs.');
									gotoxy(33,9);
									writeln('2.-2.000 Bs.');
									gotoxy(33,10);
									writeln('3.-10.000 Bs.');
									gotoxy(33,11);
									writeln('4.-20.000 Bs.');
									gotoxy(33,12);
									writeln('5.-50.000 Bs.');
									gotoxy(33,13);
									writeln('6.-REGRESAR');
									gotoxy(33,15);
									writeln('OPCION: ');
									gotoxy(41,15);
									readln(ope_monto);
									
									case ope_monto of
									
										'1':
										begin
											clrscr;
											monto := 1000;
											if usuario.saldo > monto then
											begin
												usuario.saldo := usuario.saldo - monto;
												gotoxy(33,10);
												writeln('RETIRO EXITOSO!');
												gotoxy(33,12);
												write('Presione una tecla para continuar . . .');
												gotoxy(72,12);
												readkey;
											end
											else
											begin
												gotoxy(33,10);
												writeln('SALDO INSUFICIENTE. . .');
												gotoxy(56,10);
												readkey;
											end;
											ope_monto := '6';
										end;
										
										'2':
										begin
											clrscr;
											monto := 2000;
											if usuario.saldo > monto then
											begin
												usuario.saldo := usuario.saldo - monto;
												gotoxy(33,10);
												writeln('RETIRO EXITOSO!');
												gotoxy(33,12);
												write('Presione una tecla para continuar . . .');
												gotoxy(72,12);
												readkey;
											end
											else
											begin
												gotoxy(33,10);
												writeln('SALDO INSUFICIENTE. . .');
												gotoxy(56,10);
												readkey;
											end;
											ope_monto := '6';
										end;
										
										'3':
										begin
											clrscr;
											monto := 10000;
											if usuario.saldo > monto then
											begin
												usuario.saldo := usuario.saldo - monto;
												gotoxy(33,10);
												writeln('RETIRO EXITOSO!');
												gotoxy(33,12);
												write('Presione una tecla para continuar . . .');
												gotoxy(72,12);
												readkey;
											end
											else
											begin
												gotoxy(33,10);
												writeln('SALDO INSUFICIENTE. . .');
												gotoxy(56,10);
												readkey;
											end;
											ope_monto := '6';
										end;
										
										'4':
										begin
											clrscr;
											monto := 20000;
											if usuario.saldo > monto then
											begin
												usuario.saldo := usuario.saldo - monto;
												gotoxy(33,10);
												writeln('RETIRO EXITOSO!');
												gotoxy(33,12);
												write('Presione una tecla para continuar . . .');
												gotoxy(72,12);
												readkey;
											end
											else
											begin
												gotoxy(33,10);
												writeln('SALDO INSUFICIENTE. . .');
												gotoxy(56,10);
												readkey;
											end;
											ope_monto := '6';
										end;
														
										'5':
										begin
											clrscr;
											monto := 50000;
											if usuario.saldo > monto then
											begin
												usuario.saldo := usuario.saldo - monto;
												gotoxy(33,10);
												writeln('RETIRO EXITOSO!');
												gotoxy(33,12);
												write('Presione una tecla para continuar . . .');
												gotoxy(72,12);
												readkey;
											end
											else
											begin
												gotoxy(33,10);
												writeln('SALDO INSUFICIENTE. . .');
												gotoxy(56,10);
												readkey;
											end;
											ope_monto := '6';
										end;
										
										'6':
										begin
										end;
											
										else {Mensaje de error}
										begin
											gotoxy(31,17);
											writeln('Ingrese una opcion correcta . . .');
											gotoxy(76,17);
											readkey;
											clrscr;
										end;
									end;
								until (ope_monto='6');
							end;
								
							'3': {CONSULTA}
							begin
								clrscr;
								str(usuario.saldo:0:2,dinero);
								gotoxy(33,10);
								write('SU SALDO ACTUAL ES: '+dinero+' Bs.');
								gotoxy(33,12);
								write('Presione una tecla para continuar . . .');
								gotoxy(72,12);
								readkey;
							end;
							
							'4': {HISTORICO}
							begin
								clrscr;
								gotoxy(33,12);
								write('SECCION EN DESARROLLO . . .');
								readkey;
							end;
								
							'5': {SALIR}
							begin
								clrscr;
								str(usuario.saldo:0:2,dinero);
								ReSet(respaldo_lista);
								ReWrite(lista_clientes);
								writeln(lista_clientes, usuario.cedula+'/'+usuario.nombre+'/'+usuario.apellido+'/'+dinero+'/');
								while not EOF(respaldo_lista) do
								begin
									read(respaldo_lista, caracter);
									write(lista_clientes, caracter);
								end;
								Close(lista_clientes);
								Close(respaldo_lista);
								
								gotoxy(33,10);
								write('VUELVA PRONTO!');
								gotoxy(47,10);
								readkey;
							end;
								
							else {Mensaje de error}
							begin
								gotoxy(31,17);
								writeln('Ingrese una opcion correcta . . .');
								gotoxy(76,17);
								readkey;
								clrscr;
							end;
						end;
					
					until (ope='5');
				end
				else
				begin
					gotoxy(22,6);
					writeln('ESTA CEDULA NO ESTA REGISTRADA . . .');
					gotoxy(58,6);
					readkey;
				end;
			end;
			
			'2': {FINALIZAR}
			begin
			end;
			
			else {Mensaje de error}
			begin
				gotoxy(31,17);
				writeln('Ingrese una opcion correcta . . .');
				gotoxy(76,17);
				readkey;
				clrscr;
			end;
		end;	
		
	until (ope_ini='2');
END.

