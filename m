Received:  by oss.sgi.com id <S554001AbRBWE1F>;
	Thu, 22 Feb 2001 20:27:05 -0800
Received: from agile-50.OntheNet.com.au ([203.144.13.50]:17158 "EHLO
        surfers.oz.agile.tv") by oss.sgi.com with ESMTP id <S553890AbRBWE0o>;
	Thu, 22 Feb 2001 20:26:44 -0800
Received: from agile.tv (IDENT:ldavies@tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f1N4QgV06922;
	Fri, 23 Feb 2001 14:26:42 +1000
Message-ID: <3A95E682.982AC529@agile.tv>
Date:   Fri, 23 Feb 2001 14:26:42 +1000
From:   Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@oz.agile.tv
Organization: Agile TV
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Small remote debug kernels??
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I would like to remote debug my kernel.
On the Cobalt box I have there is (allegedly) a bootloader bug that
stops the
kernel being any larger than 1M/2.5M, compressed/uncompressed.
I have stripped the kernel bare but can't get much lower than 6M
uncompressed.

Is there any way I can have a mini-remote debugging kernel??


Thanks
Liam
