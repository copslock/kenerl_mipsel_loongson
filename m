Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9H9bru22575
	for linux-mips-outgoing; Wed, 17 Oct 2001 02:37:53 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9H9bkD22556
	for <linux-mips@oss.sgi.com>; Wed, 17 Oct 2001 02:37:47 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA32644;
	Wed, 17 Oct 2001 13:37:14 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA05405; Wed, 17 Oct 2001 13:30:42 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA16246; Wed, 17 Oct 2001 12:29:14 +0300 (MSK)
Message-ID: <3BCD4FB2.D472C033@niisi.msk.ru>
Date: Wed, 17 Oct 2001 13:30:26 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Steven Liu <stevenliu@psdc.com>
CC: linux-mips@oss.sgi.com
Subject: Re: system call fork in  init.
References: <84CE342693F11946B9F54B18C1AB837B14A7CE@ex2k.pcs.psdc.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven Liu wrote:
> Currently, I am porting Linux 2.2.12 to mips a r3000 CPU. When the init
> program forked a child process and the the scheduler try to run it, the
> child's stack are all zeros.
> 
> Any one help will be greatly appreciated.
> 

Choose 2.4, 2.2 is too buggy for r3k.

Regards,
Gleb.
