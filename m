Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5JGTID22560
	for linux-mips-outgoing; Tue, 19 Jun 2001 09:29:18 -0700
Received: from spider.dcg.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5JGTHV22557
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 09:29:17 -0700
Received: from (null) ([127.0.0.1] helo=eicon.com)
	by spider.dcg.i-data.com with esmtp (Exim 3.22 #1 (Debian))
	id 15CONO-0001gS-00
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 18:29:15 +0200
Message-ID: <3B2F7DDA.68356680@eicon.com>
Date: Tue, 19 Jun 2001 18:29:14 +0200
From: Brian Murphy <brian.murphy@eicon.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: core dump support in gdb
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


The gdb versions I have used on mipsel-linux do not seem to be able to
read a core file generated on the same platform failing with

warning: Hit heuristic-fence-post without finding
warning: enclosing function for address 0x20008413

Anyone know what the problem is?
Increasing the value of heuristic-fence-post does not help. 
The address mentioned seems not to exist in the address space of 
the program. Running the program from within gdb seems however to
give meaningful results when the program crashes.

/Brian
