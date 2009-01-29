Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 13:30:52 +0000 (GMT)
Received: from ik-out-1112.google.com ([66.249.90.176]:34100 "EHLO
	ik-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S21365436AbZA2Nat convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 13:30:49 +0000
Received: by ik-out-1112.google.com with SMTP id b35so1491276ika.0
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2009 05:30:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kglSaGbaIqCCZl59Nh/Oj7xsfsHxFqzfYvHBqEdPcV0=;
        b=JmLP7iK7WZR4CIZGsHqZPol1A6ljvMVY8uVkRO5JNgEJqsy12KRckLmprobL7HEY3O
         xf01hoDpazppkgjeOs7JMkOFV9iVubYElefET1y9beMBd7vmP7qbfFpDBdF4o8ztOXVe
         ysCvJGL73932f2GRPnJOehPgTa7jGWRarqe1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=ZvWdsrcMR1SVhcSqE0PJoqVQMOJ9H0N1meS4dX+sMUzJsF7+AYER9soQUjZCF52QvT
         faGY8Sj7Agb6MAJHGza1Ccu50UnTGdKN26k945BivWb8VDvJdRQrCM69yJmVx4+Lzvhj
         9ZmF4YtTU1zSnRkTfYSU/cPeHzlb8g1m4UnOw=
Received: by 10.210.65.17 with SMTP id n17mr78484eba.112.1233235848410;
        Thu, 29 Jan 2009 05:30:48 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id 1sm29170119ewy.61.2009.01.29.05.30.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 05:30:46 -0800 (PST)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: Syntax error in include/asm-mips/gdb-stub.h
Date:	Thu, 29 Jan 2009 14:30:29 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-9-generic; KDE/4.1.3; x86_64; ; )
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901291430.30275.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

apologies for not sending a patch — I'm working with a rather
old tree (2.6.21-ish vintage) and am uncertain how useful one
would be — but just collided with a trivial syntax error in
include/asm-mips/gdb-stub.h

        long    lo;
#ifdef CONFIG_CPU_HAS_SMARTMIPS
        long    acx
#endif
        long    cp0_badvaddr;

there is missing semicolon (‘;’) on the centre line (acx).
this mistake is seems to exist in at least the following
(and very probably elsewhere (I'm not a git expert!)):

linux-2.6.25.13
linux-2.6.25.14
linux-2.6.25.15
linux-2.6.25.16
linux-2.6.25.17
linux-2.6.25.18
linux-2.6.25.19
linux-2.6.25.20
linux-2.6.26.1
linux-2.6.26.2
linux-2.6.26.3
linux-2.6.26.4
linux-2.6.26.5
linux-2.6.26.6
linux-2.6.26.7
linux-2.6.26.8

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
