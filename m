Received:  by oss.sgi.com id <S553881AbRBNMnw>;
	Wed, 14 Feb 2001 04:43:52 -0800
Received: from mail.sonytel.be ([193.74.243.200]:32931 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553720AbRBNMnf>;
	Wed, 14 Feb 2001 04:43:35 -0800
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA25909
	for <linux-mips@oss.sgi.com>; Wed, 14 Feb 2001 13:43:02 +0100 (MET)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id NAA12606
	for linux-mips@oss.sgi.com; Wed, 14 Feb 2001 13:43:01 +0100 (MET)
Date:   Wed, 14 Feb 2001 13:43:01 +0100
From:   Tom Appermont <tea@sonycom.com>
To:     linux-mips@oss.sgi.com
Subject: no page fault on R5000?
Message-ID: <20010214134301.B12039@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Howdy,
  
Is anybody running a 2.4.1 kernel on an R5000? I am currently
trying on a NEC ddb5074, but I'm not getting a page fault when
start_thread() is called for the init process...
  
Greetz,
  
Tom

-- 
................................................................
Tom Appermont                       SDCE
mailto: tom.appermont@sonycom.com   Sint Stevens Woluwestraat 55
tel: +32 2 7248620                  1130 Brussel
fax: +32 2 7262686                  Belgium
