Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 14:24:17 +0100 (BST)
Received: from web37506.mail.mud.yahoo.com ([209.191.91.153]:59748 "HELO
	web37506.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28577538AbYGNNYL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jul 2008 14:24:11 +0100
Received: (qmail 13207 invoked by uid 60001); 14 Jul 2008 13:23:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=6dwEJ38aAislPWoGGRQBJixW5o3QZwHmTEF6sx8EkTEPhqeE/MbCdon/et+G8KbDNJcFXiCvT/3IjLS6Ar5rUPfLc/iQoEZuJv5X3+d6+y0EvxdjqmVeodcELLcqgrNCT6F1QK37iUPV49zV4YDYxzStzGtFLqWQai5QrOd4LHM=;
Received: from [155.104.37.17] by web37506.mail.mud.yahoo.com via HTTP; Mon, 14 Jul 2008 06:23:49 PDT
X-Mailer: YahooMailWebService/0.7.199
Date:	Mon, 14 Jul 2008 06:23:49 -0700 (PDT)
From:	Sean Parker <seaneparker@yahoo.com>
Reply-To: seaneparker@yahoo.com
Subject: Accessing DDR DCR registers in init_mem - PMC RM9000
To:	linux-mips@linux-mips.org
Cc:	supinlick@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <23157.12397.qm@web37506.mail.mud.yahoo.com>
Return-Path: <seaneparker@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: seaneparker@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello - 

  We're trying to determine dynamically the DDR DCR register values from within setup.c, init_mem(), so that we can remove the hard-coded 256MB RAM size (and not rely on cmd-line args) From documentation I've read (not evry clear for a MIPS newbie) it appears I need to setup a TLB entry to access phys mem above 0x80000000. (PMON already sets up a range for Compact Flash)

  I setup a TLB entry for that region ( 0xFF080000, making 3 total entries setup in PMON) but I still get an exception in setup.c when I try to read the DCR reg.

  Is it as simple as setting up a TLB entry? I can't find examples for how to access registeres in various segments of physical memory (in kernel mode) does anyone know of a good resource for that kind of stuff?

  Any suggestions?

  Thanks
    Sean



      
