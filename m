Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5TM1pnC008614
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 29 Jun 2002 15:01:51 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5TM1phm008613
	for linux-mips-outgoing; Sat, 29 Jun 2002 15:01:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5TM1VnC008604
	for <linux-mips@oss.sgi.com>; Sat, 29 Jun 2002 15:01:32 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id B85DC12FF9; Sun, 30 Jun 2002 00:05:13 +0200 (CEST)
Date: Sun, 30 Jun 2002 00:05:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
Message-ID: <20020629220513.GC17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ro1PRY3Rtw8g7IwX"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Ro1PRY3Rtw8g7IwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've started looking at mips(el) again, here's some first status report
for 2.4.19-rc1. Machine is a R4600 Indy.

1st boot:
	SIGBUS for e2fsck, freeze after

2nd boot:
	Freeze somewhere during boot-up

3rd boot:
	Numerous messages like this:

		swap_free: Bad swap file entry 3c04881a
		swap_free: Bad swap offset entry 2484c500
=09
	I think this is because swap has been activated during 2nd
	boot-up and some swap pages are marked as "used" (from previous
	boot-up) but aren't used...

	Then an Oops during ntpdate (or ntp?) startup:

ksymoops 2.4.5 on mips 2.4.16.  Options used
     -v /boot/vmlinux-2.4.19-rc1--00 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.19-rc1--00 (specified)

No modules in ksyms, skipping objects
$0 : 00000000 3000cc02 c0006000 c0006622 00031180 88185d98 00031180 00000000
$8 : 88185d98 07200720 07200720 07200720 07200720 00000000 881b5cc0 07200720
$16: 8816fb5c 00000000 00031180 00121000 0030a000 8bb95244 2b0f6000 00005000
$24: 00000000 00000007                   8bb32000 8bb33df8 00000000 88040984
epc  : 88016cd8    Not tainted
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: 3000cc03
Cause : 00008010
Process mount (pid: 20, stackpage=3D8bb32000)
Stack: 8813c7e4 8813c780 24a5cb60 00000010 88040984 883bc76c 8803258c 88032=
44c
       2acf6000 2acfb000 8816fb5c ffffffbf 00000040 88030a50 8bb95300 2acf6=
000
       00000000 00000000 00000001 00005000 2acfb000 00000000 2b0f6000 8bb95=
244
       8816f300 8bb9d2b0 8bb973d4 880393e0 8816f31c 8bb95360 8bb95360 2acf5=
b6c
       8bb33ebc 8bb33eb8 8bb33ec0 8bb95300 00000073 2acf6000 8816f300 00000=
000
       00005000 ...
Code: 00000000  bc600000  bc600020 <bc600040> bc600060  bc600080  bc6000a0 =
 bc6000c0  bc6000e0=20


>>$1; 3000cc02 Before first symbol
>>$2; c0006000 <END_OF_CODE+37e4edb0/????>
>>$3; c0006622 <END_OF_CODE+37e4f3d2/????>
>>$4; 00031180 Before first symbol
>>$5; 88185d98 <swap_info+0/708>
>>$6; 00031180 Before first symbol
>>$8; 88185d98 <swap_info+0/708>
>>$9; 07200720 Before first symbol
>>$10; 07200720 Before first symbol
>>$11; 07200720 Before first symbol
>>$12; 07200720 Before first symbol
>>$14; 881b5cc0 <font_data+0/fc>
>>$15; 07200720 Before first symbol
>>$16; 8816fb5c <netfilter_init+10/48>
>>$18; 00031180 Before first symbol
>>$19; 00121000 Before first symbol
>>$20; 0030a000 Before first symbol
>>$21; 8bb95244 <END_OF_CODE+39ddff4/????>
>>$22; 2b0f6000 Before first symbol
>>$23; 00005000 Before first symbol
>>$26; 8bb32000 <END_OF_CODE+397adb0/????>
>>$27; 8bb33df8 <END_OF_CODE+397cba8/????>
>>$29; 88040984 <free_swap_and_cache+20/114>

>>PC;  88016cd8 <r4k_flush_cache_range_d32i32+dc/16c>   <=3D=3D=3D=3D=3D

Code;  88016ccc <r4k_flush_cache_range_d32i32+d0/16c>
00000000 <_PC>:
Code;  88016ccc <r4k_flush_cache_range_d32i32+d0/16c>
   0:   00000000  nop
Code;  88016cd0 <r4k_flush_cache_range_d32i32+d4/16c>
   4:   bc600000  0xbc600000
Code;  88016cd4 <r4k_flush_cache_range_d32i32+d8/16c>
   8:   bc600020  0xbc600020
Code;  88016cd8 <r4k_flush_cache_range_d32i32+dc/16c>   <=3D=3D=3D=3D=3D
   c:   bc600040  0xbc600040   <=3D=3D=3D=3D=3D
Code;  88016cdc <r4k_flush_cache_range_d32i32+e0/16c>
  10:   bc600060  0xbc600060
Code;  88016ce0 <r4k_flush_cache_range_d32i32+e4/16c>
  14:   bc600080  0xbc600080
Code;  88016ce4 <r4k_flush_cache_range_d32i32+e8/16c>
  18:   bc6000a0  0xbc6000a0
Code;  88016ce8 <r4k_flush_cache_range_d32i32+ec/16c>
  1c:   bc6000c0  0xbc6000c0
Code;  88016cec <r4k_flush_cache_range_d32i32+f0/16c>
  20:   bc6000e0  0xbc6000e0


4th boot:
	Using 2.4.16 (from Debian installer) and everything is fine
	again. Cache issues again?


MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--Ro1PRY3Rtw8g7IwX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Hi8YHb1edYOZ4bsRAjtWAJ0VMB0sldTLfjimR+sVLWwiBr9GxACfRoQe
MCd4itG5ao8YaU+jHUJHdjA=
=owG7
-----END PGP SIGNATURE-----

--Ro1PRY3Rtw8g7IwX--
