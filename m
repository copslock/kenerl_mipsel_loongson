Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4VId0nC011272
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 11:39:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4VId0C3011271
	for linux-mips-outgoing; Fri, 31 May 2002 11:39:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VIcwnC011268
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 11:38:58 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g4VIeT6F003045;
	Fri, 31 May 2002 11:40:29 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g4VIeT7C003041;
	Fri, 31 May 2002 11:40:29 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 31 May 2002 11:40:29 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: linux-mips-kernel@lists.sourceforge.net
cc: linux-mips <linux-mips@oss.sgi.com>
Subject: TX 3912 framebuffer device
In-Reply-To: <3CF6A583.2040309@mvista.com>
Message-ID: <Pine.LNX.4.44.0205311137230.28854-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Can the video mode of this device be switched at run time or is it a
static mode. I'm porting it to the new fbdev api and I want to get it
right.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/
