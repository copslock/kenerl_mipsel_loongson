Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 07:50:55 +0100 (BST)
Received: from yx-out-1718.google.com ([74.125.44.157]:54404 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20022607AbZDUGuq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 07:50:46 +0100
Received: by yx-out-1718.google.com with SMTP id 4so872576yxp.24
        for <linux-mips@linux-mips.org>; Mon, 20 Apr 2009 23:50:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=OSF528CoFF6hSW+MO+vByJ+vl+gZQRPOwTktPyYD+N8=;
        b=ex2YdHLFMsnQ+Nh0UTSy0lVLMB0Q7GFWOx3FN32O4t5xnnjKJKcpXilrXDknmU5SRy
         2R/bAaH+pxw858jXPAfHdQv/0yPh1B4vUsaZLNrgrYp2dWzq3q9Begef1BjFDMfkbeIW
         op6OPhffcpwmpcb4o1LhqGmiUxue7klf7+QUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=g/ByBjiPrygux38jNGKFlarniH7ihI0P0RJytZoWlMTSlhFMuLeKb2OJYyvZWxzMei
         egBx3hCV6xZXBU0hvGAJchiit4IeycDoinfET+ChB6SSNiNpenp5DHiacR0Ca1SIhynV
         BEk+R7i4NHluGSNgD3dZE4LNZ3UPsmOLPnuvk=
MIME-Version: 1.0
Received: by 10.100.189.10 with SMTP id m10mr3157214anf.47.1240296643964; Mon, 
	20 Apr 2009 23:50:43 -0700 (PDT)
In-Reply-To: <20090420.085929.-1089997132.imp@bsdimp.com>
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>
	 <200904201100.39164.florian@openwrt.org>
	 <20090420.085929.-1089997132.imp@bsdimp.com>
Date:	Tue, 21 Apr 2009 12:20:43 +0530
Message-ID: <d77cedf30904202350g602c740dh26641f145677ddd5@mail.gmail.com>
Subject: Re: in mips how to change the start address to the new second boot 
	loader ?
From:	nagalakshmi veeramallu <lucky.veeramallu@gmail.com>
To:	"M. Warner Losh" <imp@bsdimp.com>
Cc:	florian@openwrt.org, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64355e4e1303d04680b1023
Return-Path: <lucky.veeramallu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lucky.veeramallu@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64355e4e1303d04680b1023
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your reply.

            Actual YAMON doesn=92t have support for KMC board, hence we
modified yamon source code according to the KMC board. Now we want to put
our code into FUJITSU flash memory for testing purpose and  previous boot
loader cmon has to be protected. After power on the board, instead of cmon
we have to run our modified Yamon.

            CMON is executing perfectly, is there any possible way to go
directly to the new boot loader code directly. i have some idea, is this
approach will work

-          if we set environmental variable =93start=94 as =93go new_addres=
s=94,
will it go directly to the new bootloader in the next power-on.

-           Mips atlas board has jumper  which will redirect accesses from
=93Bootcode=94 range to either =93Monitor flash=94 (0x1e000000) or the uppe=
r 4MB of
=93System flash=94 (0x1dc00000) based on jumper settings. if my kmc board h=
ave
some jumper like this, can I redirect the start address.

Thanks in advance

 Regards,

Lucky

--0016e64355e4e1303d04680b1023
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<p><span style=3D"font-size:10.0pt;font-family:Arial;color:black">Hi,</span=
></p>

<p><span style=3D"font-size:10.0pt;font-family:Arial;color:black">Thanks fo=
r your
reply.</span></p>

<p><span style=3D"font-size:10.0pt;font-family:Arial;color:black">=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0<span class=3D"apple-converted-space">=A0</span>Act=
ual YAMON doesn=92t have support for
KMC board, hence we modified yamon source code according to the KMC board. =
Now
we want to put our code into FUJITSU flash memory for testing purpose and<s=
pan style=3D"mso-spacerun:yes">=A0 </span>previous boot loader cmon has to =
be
protected. After power on the board, instead of cmon we have to run our mod=
ified
Yamon.</span></p>

<p><span style=3D"font-size:10.0pt;font-family:Arial;color:black">=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0<span class=3D"apple-converted-space">=A0CMON</span=
> is executing perfectly, is there
any possible way to go directly to the new boot loader code directly. i hav=
e
some idea, is this approach will work</span></p>

<p style=3D"margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 lfo1;
tab-stops:list .5in"><span style=3D"font-size:10.0pt;
font-family:Arial;mso-fareast-font-family:Arial;color:black"><span style=3D=
"mso-list:Ignore">-<span style=3D"font:7.0pt &quot;Times New Roman&quot;">=
=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span></span></span><span style=3D"font-size:10.0pt;font-family:Arial;
color:black">if we set environmental variable =93start=94 as =93go new_addr=
ess=94, will
it go directly to the new bootloader in the next power-on.</span></p>

<p style=3D"margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 lfo1;
tab-stops:list .5in"><span style=3D"font-size:10.0pt;
font-family:Arial;mso-fareast-font-family:Arial;color:black"><span style=3D=
"mso-list:Ignore">-<span style=3D"font:7.0pt &quot;Times New Roman&quot;">=
=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span></span></span><span style=3D"font-size:10.0pt;font-family:Arial;
color:black"><span style=3D"mso-spacerun:yes">=A0</span>Mips atlas board ha=
s jumper
<span style=3D"mso-spacerun:yes">=A0</span>which will redirect accesses fro=
m =93Bootcode=94
range to either =93Monitor flash=94 (0x1e000000) or the upper 4MB of =93Sys=
tem flash=94
(0x1dc00000) based on jumper settings. if<span style=3D"mso-spacerun:yes">=
=A0</span>my kmc board have some jumper like this, can I redirect the start=
 address.</span></p>

<p><span style=3D"font-size:10.0pt;font-family:Arial;color:#500050">Thanks =
in
advance</span></p>

<p><span style=3D"font-size:10.0pt;font-family:Arial;color:#500050">=A0Rega=
rds,</span></p>

<p><span style=3D"font-size:10.0pt;font-family:Arial;color:#500050">Lucky</=
span></p>

--0016e64355e4e1303d04680b1023--
