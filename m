Received:  by oss.sgi.com id <S42221AbQJIUcl>;
	Mon, 9 Oct 2000 13:32:41 -0700
Received: from [206.207.108.63] ([206.207.108.63]:45891 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S42213AbQJIUci>; Mon, 9 Oct 2000 13:32:38 -0700
Received: (qmail 16904 invoked from network); 9 Oct 2000 14:32:27 -0600
Received: from gmcnutt-lx.ridgerun.cxm (HELO ridgerun.com) (gmcnutt@192.168.1.17)
  by ridgerun-lx.ridgerun.cxm with SMTP; 9 Oct 2000 14:32:27 -0600
Message-ID: <39E22B5A.66587B5A@ridgerun.com>
Date:   Mon, 09 Oct 2000 14:32:26 -0600
From:   Gordon McNutt <gmcnutt@ridgerun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: sgiserial.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm trying to get the Indy's serial port to drive a peripheral card at
115200 baud. It appears to work OK at 9600 baud (the serial port that is
-- the card expects 115200 baud).

First of all, it lookslike the baud_table (in sgiserial.c) used to
convert termios.c_cflag bits to a numeric baud rate was outdated so I
fixed it up. Didn't help. It looks like transmit interrupts are
occurring and the driver is trying to write them to the chip (one byte
per interrupt..? ok, whatever works), but the other end usually isn't
getting anything. When reading, the Indy seems to get bytes but they
don't look good.

BTW, I've tried compiling the kernel without console support on the
serial line but I still get some console messages during boot (at 9600
baud). Haven't  looked too hard at that yet... When I force everybody to
use 115200 baud (via a hack) I don't see the console messages (yes, I
changed minicom to expect 115200 in this case). It just seems like the
chip is not correctly being set to operate at 115200 -- even when
I force it to try.

Has anybody else tried to make the serial port speak 115200?

Thanks,
--Gordon
