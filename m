Received:  by oss.sgi.com id <S553740AbQJTSPg>;
	Fri, 20 Oct 2000 11:15:36 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:39153 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553728AbQJTSPT>;
	Fri, 20 Oct 2000 11:15:19 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9KID8x05243;
	Fri, 20 Oct 2000 11:13:08 -0700
Message-ID: <39F08BD9.BB56D050@mvista.com>
Date:   Fri, 20 Oct 2000 11:15:53 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     jbglaw@lug-owl.de
CC:     debian-mips|lists.debian.org@lug-owl.de, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: mipsel base.tgz
References: <20001020200150.C25684@lug-owl.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jan-Benedict Glaw wrote:
> 
> Hi!
> 
> I'm currently working on a base.tgz for Debian Woody on little
> endian MIPS machines (I'm working on a DECStation 5000/120).
> 
> Currently, I've got problems with these packages:
> 
> - netbase_4.05.deb
>   ppp_2.4.0f-1_mipsel.deb
>   pppconfig_2.0.5.deb
>   telnetd_0.16-4_mipsel.deb
>   ---> They depend (more or less) on (net-tools|iproute) which I
>        haven't found any packages for
> 

A couple of days ago I built telnetd based on MontaVista CDK 1.2 build
system.  It is working well. You can find out the details of the build
by checking out the source rpm.

ftp://ftp.mvista.com/Area51/mips_le/

Jun
