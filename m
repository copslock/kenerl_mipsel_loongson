Received:  by oss.sgi.com id <S553679AbQJTNDn>;
	Fri, 20 Oct 2000 06:03:43 -0700
Received: from router.isratech.ro ([193.226.114.69]:65298 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553663AbQJTNDk>;
	Fri, 20 Oct 2000 06:03:40 -0700
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id e9KD2bZ28883
	for <linux-mips@oss.sgi.com>; Fri, 20 Oct 2000 11:03:01 -0200
Message-ID: <39F040D4.4BFB2E26@isratech.ro>
Date:   Fri, 20 Oct 2000 15:55:48 +0300
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: [Fwd: CrossGcc steps!]
Content-Type: multipart/mixed;
 boundary="------------E402C82F993BDC9EE33D3592"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------E402C82F993BDC9EE33D3592
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------E402C82F993BDC9EE33D3592
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <39F03E3E.F3F58745@isratech.ro>
Date: Fri, 20 Oct 2000 15:44:46 +0300
From: Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jbglaw@lug-owl.de, linuix-mips@oss.sgi.com
Subject: Re: CrossGcc steps!
References: <20001019081727.A8870@lug-owl.de> <39EE99E6.96E07087@isratech.ro> <20001019094429.A9454@lug-owl.de> <39EEAC8E.B510FFD2@isratech.ro> <20001019103728.B9832@lug-owl.de> <39EEB80A.C0B989F5@isratech.ro> <20001019110946.C9832@lug-owl.de> <39EEC729.2081E422@isratech.ro> <20001019122516.G9832@lug-owl.de> <39EF0FE2.1BBD2B63@isratech.ro> <20001020144609.B23056@lug-owl.de>
Content-Type: multipart/mixed;
 boundary="------------D54BA50BC698C570DE80298D"

This is a multi-part message in MIME format.
--------------D54BA50BC698C570DE80298D
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello ,

I will keep the lines smaller than 70 bytes!

Jan-Benedict Glaw wrote:

> On Thu, Oct 19, 2000 at 06:14:42PM +0300, Nicu Popovici wrote:
> > Hello Jan,
> >
> > Finally I have the CVS linux tree in my directory but now I have another problem. As I said I used
> > binutils 2.8.1 with patches anf egcs1.0.3a with patches but when I do make clean make dep and make
> > I get the following error at make:
>
> ----> Please keep your lines shorter than about 70 bytes! <-----
>
> [Lots of missing symbols though missing objects]
>
> > Can anyone help me with this kind of error ?
>
> Yupp. Your .config is wrong. What kind of machine do you exactly ghave?

I have a Intel pentium III at 500 Mhz which is running RedHat 6.2.

>
>
> > What I wanted to ask you is : did you make any particular configuration for this kernel with make
> > menuconfig ?
>
> You need to have an *exactly* fitting config. You're responsible
> to make it by config/oldconfig/menuconfig/xconfig, as what you prefer.

Can you help me with the options ?

>
>
> > Or the problem is not from the CVS kernel ?
>
> No. You've choosen wrong options;)
>
> MfG, JBG
>
> --
> Fehler eingestehen, Größe zeigen: Nehmt die Rechtschreibreform zurück!!!
> /* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
> keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 8399 E1BB
>      "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

--------------D54BA50BC698C570DE80298D
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:Popovici;Nicu
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;software 
adr:;;;IASI;IASI;6600;ROMANIA
version:2.1
email;internet:octavp@isratech.ro
title:software engineer
x-mozilla-cpt:;0
fn:Nicu Popovici
end:vcard

--------------D54BA50BC698C570DE80298D--


--------------E402C82F993BDC9EE33D3592
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:Popovici;Nicu
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;software 
adr:;;;IASI;IASI;6600;ROMANIA
version:2.1
email;internet:octavp@isratech.ro
title:software engineer
x-mozilla-cpt:;0
fn:Nicu Popovici
end:vcard

--------------E402C82F993BDC9EE33D3592--
