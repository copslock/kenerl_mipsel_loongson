Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3J81uV15793
	for linux-mips-outgoing; Thu, 19 Apr 2001 01:01:56 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3J81nM15788;
	Thu, 19 Apr 2001 01:01:49 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA12116;
	Thu, 19 Apr 2001 10:01:47 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id KAA00476;
	Thu, 19 Apr 2001 10:01:47 +0200 (MET DST)
Date: Thu, 19 Apr 2001 10:01:47 +0200
From: Tom Appermont <tea@sonycom.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: address translation with TLB
Message-ID: <20010419100147.A467@ginger.sonytel.be>
References: <20010414102901.A13595@ginger.sonytel.be> <20010417141122.D7177@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010417141122.D7177@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Apr 17, 2001 at 02:11:22PM -0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 17, 2001 at 02:11:22PM -0300, Ralf Baechle wrote:
> 
> Sane designs make sure that peripherals are at physical addresses of 512mb
> or less so can be addressed through KSEG1 without using TLB entries.  So
> far the only violation of this rule are the Jazz systems.
> 

In the setup.c file for the jazz board, is written:

        add_wired_entry (0x02000017, 0x03c00017, 0xe0000000, PM_64K);
        add_wired_entry (0x02400017, 0x02440017, 0xe2000000, PM_16M);
        add_wired_entry (0x01800017, 0x01000017, 0xe4000000, PM_4M);


Why do these physical addresses which are all below 512MB need TLB entries? 


Greetz,

Tom
