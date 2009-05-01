Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 22:47:35 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:56394 "EHLO
	mail-bw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20027867AbZEAVr2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 22:47:28 +0100
Received: by bwz25 with SMTP id 25so2655882bwz.0
        for <multiple recipients>; Fri, 01 May 2009 14:47:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=mng4vw6dm21qh7/q+QJctc3NV+qYTC1IRY7MqV61E1U=;
        b=yBhjkmWl83f7r+hD4ofFb3pGwHcUU/Rw8QFdmScKLpm4U4JnEiUC5QRpAZ3DO9iTsY
         FeIat+TiehhbxDJdQJ/8GsRMR3f2fqLUqaiOC9A9PFgCUVLOSDXxqzx5Q0AC7FdRgDIB
         y4ZRBrHTKPsXMwEjTCbPD7S/yEmR3zDWjPae0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IaXKigzjNJmm/l6CdDsX1aytbuDHM/BA52TPzXQC4HWXmLGDqD0NdT3qPNgDO2WtBB
         5HdwBiXncwZy/foVhIUgYzpMhY7wzdZJpgHaJ4RMi6/A6aletBE/QnK2BcYr1Ogfl0Ks
         uGE64q2Ltz1wdIGipZExqsVIovu0Sq0yUNf4o=
Received: by 10.204.53.143 with SMTP id m15mr2983774bkg.119.1241214438233;
        Fri, 01 May 2009 14:47:18 -0700 (PDT)
Received: from edgar.iglesias@gmail.com (c83-249-210-227.bredband.comhem.se [83.249.210.227])
        by mx.google.com with ESMTPS id g28sm5040063fkg.5.2009.05.01.14.47.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 14:47:17 -0700 (PDT)
Received: by edgar.iglesias@gmail.com (sSMTP sendmail emulation); Fri, 01 May 2009 23:47:13 +0200
Date:	Fri, 1 May 2009 23:47:13 +0200
From:	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To:	Christoph Lameter <cl@linux.com>
Cc:	Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@MIT.EDU>,
	Anders Kaseorg <andersk@MIT.EDU>,
	Waseem Daher <wdaher@MIT.EDU>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@MIT.EDU>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bryan Wu <cooloney@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, dev-etrax@axis.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@uclinux.org>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Hirokazu Takata <takata@linux-m32r.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jeff Dike <jdike@addtoit.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
	linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	Mikael Starvik <starvik@axis.com>,
	Paul Mackerras <paulus@samba.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@twiddle.net>,
	Roman Zippel <zippel@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	user-mode-linux-devel@lists.sourceforge.net,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [microblaze-uclinux] Re: [PATCH 6/6] Add support for
	__read_mostly to linux/cache.h
Message-ID: <20090501214713.GB12724@laped.iglesias.mooo.com>
References: <1241119956-31453-1-git-send-email-tabbott@mit.edu> <1241119956-31453-2-git-send-email-tabbott@mit.edu> <1241119956-31453-3-git-send-email-tabbott@mit.edu> <1241119956-31453-4-git-send-email-tabbott@mit.edu> <1241119956-31453-5-git-send-email-tabbott@mit.edu> <1241119956-31453-6-git-send-email-tabbott@mit.edu> <1241119956-31453-7-git-send-email-tabbott@mit.edu> <20090501094407.GD18326@uranus.ravnborg.org> <alpine.DEB.1.10.0905010948140.18324@qirst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0905010948140.18324@qirst.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <edgar.iglesias@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edgar.iglesias@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 01, 2009 at 09:52:18AM -0400, Christoph Lameter wrote:
> On Fri, 1 May 2009, Sam Ravnborg wrote:
> 
> > Are there any specific reason why we do not support read_mostly on all
> > architectures?
> 
> Not that I know of.
> 
> > read_mostly is about grouping rarely written data together
> > so what is needed is to introduce this section in the remaining
> > archtectures.
> >
> > Christoph - git log says you did the inital implmentation.
> > Do you agree?
> 
> Yes.
> 
> There is some concern that __read_mostly is needlessly applied to
> numerous variables that are not used in hot code paths. This may make
> __read_mostly ineffective and actually increase the cache footprint of a
> function since global variables are no longer in the same cacheline. If
> such a function is called and the caches are cold then two cacheline
> fetches have to be done instead of one.

FWIW I think that's a valid concern. Also, I think one can question the
value of __read_mostly for write-through caches, given the mentioned
concern it probably makes things worse for those. IMO there should be
a way to turn it off for arch's that know it's no good for them.

Cheers
