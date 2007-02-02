Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 21:30:51 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:31673 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20039278AbXBBVar (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 21:30:47 +0000
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1HD5vz-0007dP-Vx; Fri, 02 Feb 2007 22:27:07 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>)
	id 1HD5wb-00073t-MA; Fri, 02 Feb 2007 22:27:41 +0100
Date:	Fri, 2 Feb 2007 22:27:41 +0100
From:	Rodolfo Giometti <giometti@enneenne.com>
To:	Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
Message-ID: <20070202212741.GH8882@enneenne.com>
References: <20070129230755.GA8705@enneenne.com> <20070130010055.GA15907@linux-sh.org> <20070201095904.GE8882@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070201095904.GE8882@enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH 1/1] APM-EMULATION: apm_get_power_status() should be NULL on init [was: Advice on battery support]
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@enneenne.com
Precedence: bulk
X-list: linux-mips

APM-EMULATION: apm_get_power_status() should be NULL on init.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

---

If the function apm_get_info() do like this:

   static int apm_get_info(char *buf, char **start, off_t fpos, int length)
   {
           struct apm_power_info info;
           char *units;
           int ret;

           info.ac_line_status = 0xff;
           info.battery_status = 0xff;
           info.battery_flag   = 0xff;
           info.battery_life   = -1;
           info.time           = -1;
           info.units          = -1;

           if (apm_get_power_status)
                   apm_get_power_status(&info);
   ...

we shouldn't set:

   static void __apm_get_power_status(struct apm_power_info *info)
   {
   }

   void (*apm_get_power_status)(struct apm_power_info *) = __apm_get_power_status;

otherwise the check is not needed. Furthermore setting the function to
NULL signals that the apm-emulation layer is not already assigned (I
found this very useful for my apm-emulation battery_class support).
