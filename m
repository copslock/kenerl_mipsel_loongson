Received:  by oss.sgi.com id <S553801AbRALOl1>;
	Fri, 12 Jan 2001 06:41:27 -0800
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:7042 "EHLO
        mailgate1.zdv.Uni-Mainz.DE") by oss.sgi.com with ESMTP
	id <S553797AbRALOlC>; Fri, 12 Jan 2001 06:41:02 -0800
Received: from arthur.zdv.Uni-Mainz.DE (arthur.zdv.Uni-Mainz.DE [134.93.8.145])
	by mailgate1.zdv.Uni-Mainz.DE (8.11.0/8.10.2) with ESMTP id f0CEf0M28592;
	Fri, 12 Jan 2001 15:41:00 +0100 (MET)
Received: (from martin@localhost)
	by arthur.zdv.Uni-Mainz.DE (8.10.2/8.10.2) id f0CEf0R09870;
	Fri, 12 Jan 2001 15:41:00 +0100 (MET)
To:     Joe deBlaquiere <jadb@redhat.com>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        linux-mips <linux-mips@fnet.fr>
Subject: Re: strace package
References: <3A5E75C4.2020203@redhat.com>
From:   Christoph Martin <martin@uni-mainz.de>
Date:   12 Jan 2001 15:40:59 +0100
In-Reply-To: Joe deBlaquiere's message of Thu, 11 Jan 2001 21:11:00 -0600
Message-ID: <wwgvgrkesuc.fsf@arthur.zdv.Uni-Mainz.DE>
X-Mailer: Gnus v5.3/Emacs 19.34
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Joe deBlaquiere <jadb@redhat.com> writes:

> 
> Has anybody done a port of strace for linux/mips 2.4??? I'm trying to 
> debug something and need something simple.
> -- 
> Joe deBlaquiere
> Red Hat, Inc.
> 307 Wynn Drive
> Huntsville AL, 35805
> voice : (256)-704-9257
> fax   : (256)-837-3839
> 

There is a debian package of strace for mips in
ftp://ftp.rfc822.org/pub/local/debian-mips/packages/. It is working
with linux 2.4.

C

-- 
============================================================================
Christoph Martin, Uni-Mainz, Germany
 Internet-Mail:  Christoph.Martin@Uni-Mainz.DE
--------------export-a-crypto-system-sig -RSA-3-lines-PERL------------------
#!/usr/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
#what's this? see http://www.dcs.ex.ac.uk/~aba/rsa/
