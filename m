Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8P7X4714032
	for linux-mips-outgoing; Tue, 25 Sep 2001 00:33:04 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8P7X1D14029
	for <linux-mips@oss.sgi.com>; Tue, 25 Sep 2001 00:33:01 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA24328
	for <linux-mips@oss.sgi.com>; Tue, 25 Sep 2001 09:32:55 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.3+Sun/8.9.3) id JAA16092
	for linux-mips@oss.sgi.com; Tue, 25 Sep 2001 09:32:58 +0200 (MEST)
X-Authentication-Warning: ginger.sonytel.be: tea set sender to tea@sonycom.com using -f
Date: Tue, 25 Sep 2001 09:32:58 +0200
From: Tom Appermont <tea@sonycom.com>
To: linux-mips@oss.sgi.com
Subject: flush_cache_range
Message-ID: <20010925093258.A16068@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,

Can someone explain me why start and end parameters are ignored in
r4k_flush_cache_range_d32i32() and cache range flushing operations
for other platforms?

Tom
