Received:  by oss.sgi.com id <S554077AbRBNECU>;
	Tue, 13 Feb 2001 20:02:20 -0800
Received: from agile-50.OntheNet.com.au ([203.144.13.50]:35337 "EHLO
        surfers.oz.agile.tv") by oss.sgi.com with ESMTP id <S554073AbRBNECD>;
	Tue, 13 Feb 2001 20:02:03 -0800
Received: from agile.tv (IDENT:ldavies@tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f1E420V24839
	for <linux-mips@oss.sgi.com>; Wed, 14 Feb 2001 14:02:00 +1000
Message-ID: <3A8A02E6.9030408@agile.tv>
Date:   Wed, 14 Feb 2001 14:00:38 +1000
From:   Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@oz.agile.tv
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips <linux-mips@oss.sgi.com>
Subject: Ooops in kmalloc from request_region
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I am currently at the stage of calling request_region in my irq_setup 
function.
The call to request_region does a kmalloc which oops. The box has 256Mb Ram.

Is this the right stage to be doing this call? Is there something that I 
have missed
in setting up the memory regions or paging?


Thanks
Liam Davies



Unable to handle kernel paging request at virtual address 10003278, epc 
== 80035314, ra == 800a1d60
Oops in fault.c:do_page_fault, line 172:


static void __init cobalt_irq_setup(void)
{
       set_cp0_status(ST0_IM, 0);

       set_except_vector(0, cobalt_handle_int);

---->> request_region(0xb0000020, 0x20, "pic1");
       request_region(0xb00000A0, 0x20, "pic2");
...
