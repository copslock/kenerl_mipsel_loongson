Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OHSDnC003080
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 10:28:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OHSDaR003079
	for linux-mips-outgoing; Mon, 24 Jun 2002 10:28:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OHS7nC003076
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 10:28:07 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5baeba892089471972151@nwd2mime2.analog.com>;
 Mon, 24 Jun 2002 13:31:24 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb2.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id NAA11916; Mon, 24 Jun 2002 13:31:18 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id KAA17700;
	Mon, 24 Jun 2002 10:31:16 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id KAA24572;
	Mon, 24 Jun 2002 10:31:16 -0700 (PDT)
Message-ID: <3D175764.48E562F7@analog.com>
Date: Mon, 24 Jun 2002 10:31:16 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Domcan Sami <domca_psg@email.com>
CC: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
   redhat-list@redhat.com
Subject: Re: Linux Boot sequence on MIPS??
References: <20020622093321.25583.qmail@email.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Domcan Sami wrote:
> 
> Hello everybody
>  I m trying to develop a Linux boot-loader for MIPS processor, can
> anybody help me sending the Linux boot sequence on MIPS. Any sites for
> reference? Thanks
> 

Where do you expect to load the kernel from? And what CPU/Board? 

The basic process is to POST the board, load the kernel into SDRAM,
and run the kernel. Where you want to load the kernel from determines
the other initialization work you need to do. 

Alternately, have you looked at PMON? It may provide everything you
need for a MIPS-based system. 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
