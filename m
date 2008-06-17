Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2008 18:46:19 +0100 (BST)
Received: from web51908.mail.re2.yahoo.com ([206.190.48.71]:14194 "HELO
	web51908.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20025507AbYFQRp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2008 18:45:59 +0100
Received: (qmail 33723 invoked by uid 60001); 17 Jun 2008 17:45:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=vLRVdOyXCJkSNt8PKLQWzw07+4958MuiI+/2Q4eoolarFUCyTjQRwk29jlj0G3nQcYySuDn6TYaSL8ga4nlozXkdd+Bis/Sr6uGKYbqNfNRjedhY7Pn+WJY6i7tazrwBqClEh9lwiQ1rsY1tH4634MSQsE66Zc9KRru8CXx+hDc=;
Received: from [155.104.37.18] by web51908.mail.re2.yahoo.com via HTTP; Tue, 17 Jun 2008 10:45:01 PDT
X-Mailer: YahooMailWebService/0.7.199
Date:	Tue, 17 Jun 2008 10:45:01 -0700 (PDT)
From:	Sean Parker <supinlick@yahoo.com>
Reply-To: supinlick@yahoo.com
Subject: Linux Boot RAM Determination
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <368058.32705.qm@web51908.mail.re2.yahoo.com>
Return-Path: <supinlick@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: supinlick@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello -

  We're developing a PMC-Sierra RM9000 system, and when Linux boots it seems to only see 256M RAM (cat /proc/meminfo -> MemTotal=256M), despite a Crucial 1GB double-sided SODIMM card.

  The boot code is PMON, and it recognizes all 1GB (dimm0:2 Ranks each 512MB) and prints as much when it's done.

  Is there a setting in the Linux source (we're using a single elf image with ramfs integrated) that might be limiting the MemTotal/RAM size found by Linux? I couldn't find anywhere in the Linux code (patched by PMC) that mentions reading the DDR DCR's to inspect what the configured RAM sizes/offsets are. Any ideas?

  Thanks and God Bless,
    Sean Parker 




      
