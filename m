Received:  by oss.sgi.com id <S554027AbRAWQML>;
	Tue, 23 Jan 2001 08:12:11 -0800
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:55509 "EHLO
        mailgate1.zdv.Uni-Mainz.DE") by oss.sgi.com with ESMTP
	id <S554024AbRAWQLw>; Tue, 23 Jan 2001 08:11:52 -0800
Received: from arthur.zdv.Uni-Mainz.DE (arthur.zdv.Uni-Mainz.DE [134.93.8.145])
	by mailgate1.zdv.Uni-Mainz.DE (8.11.0/8.10.2) with ESMTP id f0NGBjM04542;
	Tue, 23 Jan 2001 17:11:45 +0100 (MET)
Received: (from martin@localhost)
	by arthur.zdv.Uni-Mainz.DE (8.10.2/8.10.2) id f0NGBiZ02165;
	Tue, 23 Jan 2001 17:11:44 +0100 (MET)
To:     Dave Gilbert <gilbertd@treblig.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Trying to boot an Indy
References: <Pine.LNX.4.10.10101210150410.964-100000@tardis.home.dave>
From:   Christoph Martin <martin@uni-mainz.de>
Date:   23 Jan 2001 17:11:44 +0100
In-Reply-To: Dave Gilbert's message of Sun, 21 Jan 2001 02:01:15 +0000 (GMT)
Message-ID: <wwgofwyckov.fsf@arthur.zdv.Uni-Mainz.DE>
X-Mailer: Gnus v5.3/Emacs 19.34
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Dave Gilbert <gilbertd@treblig.org> writes:

> 
> Hi,
>   I'm trying to boot my Indy into Linux for the first time and not having
> any luck.
> 
> 1) I tried bootp - bootp()vmlinux - it says 'no server for vmlinux'.  The
> bootp server is a Linux/Alpha box running 2.4.0-ac9 - I've already done
> the trick with no_pmtu.  tcpdump shows bootp sending a packet with
> apparently the correct mac address.
> 

I have the same problem serving bootp from my i386 2.4.0 box. bootp
with kernel 2.2.x on the same box works. And it is only the bootp from
the command console that is failing. the bootp part later on in the
kernel is working from the 2.4.0 box.

Weird.

-- 
============================================================================
Christoph Martin, Uni-Mainz, Germany
 Internet-Mail:  Christoph.Martin@Uni-Mainz.DE
--------------export-a-crypto-system-sig -RSA-3-lines-PERL------------------
#!/usr/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
#what's this? see http://www.dcs.ex.ac.uk/~aba/rsa/
