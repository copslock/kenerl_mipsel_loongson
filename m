Received:  by oss.sgi.com id <S553795AbRBTEmM>;
	Mon, 19 Feb 2001 20:42:12 -0800
Received: from agile-50.OntheNet.com.au ([203.144.13.50]:34316 "EHLO
        surfers.oz.agile.tv") by oss.sgi.com with ESMTP id <S553772AbRBTElr>;
	Mon, 19 Feb 2001 20:41:47 -0800
Received: from agile.tv (IDENT:ldavies@tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f1K4fjV26637;
	Tue, 20 Feb 2001 14:41:45 +1000
Message-ID: <3A91F56F.9020603@agile.tv>
Date:   Tue, 20 Feb 2001 14:41:19 +1000
From:   Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@oz.agile.tv
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips <linux-mips@oss.sgi.com>
Subject: pci io remapping and ide_ioreg_t
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have an old (2.0.x) ide driver that used to hard code the 
hwif->io_ports up to the 0x100001f0-0x100001f7 range. This is now broken 
in the 2.4 kernel since ide_ioreg_t has changed from unsigned long to 
unsigned short.

What is the mechanism for reaching these ports now?


Thanks
Liam
