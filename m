Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2007 13:57:52 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:32702 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20022056AbXFLM5t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2007 13:57:49 +0100
Received: (qmail 15316 invoked by uid 507); 12 Jun 2007 21:09:30 +0800
Received: from unknown (HELO ?192.168.1.9?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 12 Jun 2007 21:09:30 +0800
Message-ID: <466E9833.4000302@ict.ac.cn>
Date:	Tue, 12 Jun 2007 20:57:23 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	tiansm@lemote.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 09/15] add serial port definition for lemote fulong
References: <11811127722019-git-send-email-tiansm@lemote.com> <11811127741719-git-send-email-tiansm@lemote.com> <20070612123440.GC2926@linux-mips.org>
In-Reply-To: <20070612123440.GC2926@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips


>>  #endif /* _ASM_SERIAL_H */
>>     
>
> I wonder, is the standard CONFIG_HAVE_STD_PC_SERIAL_PORT which does
> basically the same thing as above but for all four ports of a typical
> PC-style 16652 configuration for some reason inacceptable for Fulong?
>
>   Ralf
>   
I think CONFIG_HAVE_STD_PC_SERIAL_PORT is ok, especially for that we now 
have CONFIG_SERIAL_8250_NR_UARTS.
Nothing special for Fulong's serial ports(we used to have a special 
serial port inside the northbridge FPGA), and the 686B is
"Standard PC" chip:)
We can take the simple way.
>
>
>
>   

-- 
------------------------------------------------
Fuxin Zhang

Vice Researcher
Microprocessor Research Center, Institute of Computing Technolgy
Chiese Academy of China
Beijing, 100080
Email: fxzhang@ict.ac.cn
http://www.ict.ac.cn

------------------------------------------------
 
