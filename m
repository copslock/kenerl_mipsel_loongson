Received:  by oss.sgi.com id <S553893AbRCFGp5>;
	Mon, 5 Mar 2001 22:45:57 -0800
Received: from agile-50.OntheNet.com.au ([203.144.13.50]:23052 "EHLO
        surfers.oz.agile.tv") by oss.sgi.com with ESMTP id <S553890AbRCFGpe>;
	Mon, 5 Mar 2001 22:45:34 -0800
Received: from agile.tv (IDENT:ldavies@tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f266jXO24529;
	Tue, 6 Mar 2001 16:45:33 +1000
Message-ID: <3AA4878C.F10825DE@agile.tv>
Date:   Tue, 06 Mar 2001 16:45:32 +1000
From:   Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@oz.agile.tv
Organization: Agile TV
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Troubles with TLB refills
References: <3AA30A91.B5842678@agile.tv> <20010305114926.A26862@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,

>From the change 1.42 to 1.43 on file arch/mips/kernel/traps.c some code was
added
to copy the EJTAG exception vector

+ /*
+  * Copy the EJTAG debug exception vector handler code to it's final
+  * destination.
+  */
+ memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);

This code indescriminatly smashes the end of except_vec0_r4600 and
all of except_vec0_nevada handlers with the .fill set to only 0x280
00000000800002d4 T except_vec0_r4600
0000000080000328 T except_vec0_nevada
0000000080000380 T except_vec0_r45k_bvahwbug

I'm not sure under what platform we need to load JTAG support, but we can
just increase the fill area in head.S to say 0x400

Cheers
Liam

=-------------=
Agile TV Corporation
