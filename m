Received:  by oss.sgi.com id <S553688AbRAEK3u>;
	Fri, 5 Jan 2001 02:29:50 -0800
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:21738 "EHLO
        mailgate1.zdv.Uni-Mainz.DE") by oss.sgi.com with ESMTP
	id <S553655AbRAEK3f>; Fri, 5 Jan 2001 02:29:35 -0800
Received: from arthur.zdv.Uni-Mainz.DE (arthur.zdv.Uni-Mainz.DE [134.93.8.145])
	by mailgate1.zdv.Uni-Mainz.DE (8.11.0/8.10.2) with ESMTP id f05ATXM27303;
	Fri, 5 Jan 2001 11:29:33 +0100 (MET)
Received: (from martin@localhost)
	by arthur.zdv.Uni-Mainz.DE (8.10.2/8.10.2) id f05ATW124161;
	Fri, 5 Jan 2001 11:29:32 +0100 (MET)
From:   Christoph Martin <martin@uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14933.41481.359719.747161@arthur.zdv.Uni-Mainz.DE>
Date:   Fri, 5 Jan 2001 11:29:29 +0100 (MET)
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     Christoph Martin <martin@uni-mainz.de>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, debian-mips@lists.debian.org
Subject: Re: glibc 2.2 on MIPS
In-Reply-To: <3A55F882.4B693DE3@isratech.ro>
References: <14932.57412.617757.439688@arthur.zdv.Uni-Mainz.DE>
	<3A55F882.4B693DE3@isratech.ro>
X-Mailer: VM 6.75 under Emacs 19.34.1
Organization: Johannes Gutenberg-Universitaet Mainz
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici writes:
 > Hello all,
 > 
 > My question is somehow related on the problems showed in this email. Sorry if this
 > will bother you.
 > I am trying to setup a cross toolchain for mips and  I have to use binutils 2.10
 > and gcc 2.95.2 and glibc2.1.3. Currently I am trying to setup binutils 2.10 with
 > egcs1.0.3a and with glibc.2.0.6 . Do you have any patches for binutils 2.10 or for
 > gcc2.95.2 for mips ? If you have and if you have some ideeas please tell me ..
 > 

Look for the patches in the respective archives on:

ftp.ds2.pg.gda.pl/pub/macro/SRPMS/

Christoph
