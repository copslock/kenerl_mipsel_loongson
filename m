Received:  by oss.sgi.com id <S553854AbRAYA6K>;
	Wed, 24 Jan 2001 16:58:10 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:46430 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553890AbRAYA5k>;
	Wed, 24 Jan 2001 16:57:40 -0800
Received: from lappi.waldorf-gmbh.de (dhcp-163-154-5-208.engr.sgi.com [163.154.5.208]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA04846
	for <linux-mips@oss.sgi.com>; Wed, 24 Jan 2001 16:56:42 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870761AbRAYAbC>; Wed, 24 Jan 2001 16:31:02 -0800
Date: 	Wed, 24 Jan 2001 16:31:02 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Pete Popov <ppopov@mvista.com>, Quinn Jensen <jensenq@Lineo.COM>,
        linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
Message-ID: <20010124163101.F863@bacchus.dhis.org>
References: <3A6E132B.9000103@Lineo.COM> <3A6E1977.2B18484D@mvista.com> <3A6F36B8.4F10759B@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A6F36B8.4F10759B@mvista.com>; from jsun@mvista.com on Wed, Jan 24, 2001 at 12:10:32PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 12:10:32PM -0800, Jun Sun wrote:

> It is really surprising to know this.  It sounds like a CPU bug to me.  Can
> some MIPS "gods" clarify if such a behaviour is a bug or allowed?
> 
> BTW, the CPU in EV96100 is QED RM7000, I believe.

If you want to be strictly correct you have to execute the code that
disables caching of KSEG0 in uncached space like KSEG1, then flush the
caches before you can resume execution in KSEG0.  Otherwise you might
end up with dirty d-caches which when flushed will overwrite more
uptodate data in memory.  The window is very small but yet exists if
things are just right.

  Ralf
