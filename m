Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2TDaV216101
	for linux-mips-outgoing; Fri, 29 Mar 2002 05:36:31 -0800
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2TDaPq16086;
	Fri, 29 Mar 2002 05:36:25 -0800
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP
	id B187B92452; Sat, 30 Mar 2002 00:38:45 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP
	id 377B1237BB; Fri, 29 Mar 2002 14:38:36 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: raoul@shuttle.de (Raoul Borenius),
   Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Date: Fri, 29 Mar 2002 14:38:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "'Raoul Borenius'" <raoul@shuttle.de>, linux-mips@oss.sgi.com,
   devfs@oss.sgi.com
References: <20020329103244.GA15765@bunny.shuttle.de> <000001c1d711$2492f070$1fc1f2a3@mow.siemens.ru> <20020329132650.GA16905@bunny.shuttle.de>
In-Reply-To: <20020329132650.GA16905@bunny.shuttle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020329133836.377B1237BB@lyta.coker.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You need some code similar to the following in the serial driver:

#ifdef CONFIG_DEVFS_FS
        serial_driver.name = "tts/%d";
#else
        serial_driver.name = "ttyS";
#endif

Of course if the original device nodes were named /dev/ttyZ0 etc then you 
want "tts/Z%d".

Look at the Cyclades and Stallion drivers for examples of it being done 
correctly.  Or tell me exactly the details of what you want and I'll send you 
a patch.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.
