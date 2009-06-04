Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 08:50:04 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.153]:2221 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022351AbZFDHt6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 08:49:58 +0100
Received: by fg-out-1718.google.com with SMTP id 22so212551fge.9
        for <multiple recipients>; Thu, 04 Jun 2009 00:49:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=T9GRYk3HS1OUnG+AhAAbyoK3MZ/MAuRVxUmXWlg2b78=;
        b=eaODcN+QvbX/TXfWvki9x4Daj3yVHEEbDcrKh3xpE+9YtytD5K7+K5kGpsB2f08PQs
         ajDo+lCmtmK88bMNE22g+T3ixe/I5B2+K6ScSvEeFoEk4kWQ1g7OQYx24hqBAFRe3Kla
         Vm/z7qTaqmM6g0MwB5GqazsYJB+/y2NxNvLzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fnoy2JTzYfn0xuJyqO1dDgWj2ACqxRYQBfDd70rmhhHuUHWG5e6v6xiGBEvN3R/l+n
         xAjdT3XUY5qkInId6FfaD9hfpuB3vPfQOpNuS5RMssm+coURMg/BnJRd2t9Hd8m5Du9U
         oKRtNidgi9m/HH0mO44ymuiAdjMbq6MxkkVZY=
Received: by 10.86.96.1 with SMTP id t1mr2097121fgb.68.1244101797557;
        Thu, 04 Jun 2009 00:49:57 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id e11sm1136653fga.16.2009.06.04.00.49.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 00:49:54 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/7] Staging: Octeon-ethernet driver.
Date:	Thu, 4 Jun 2009 09:49:52 +0200
User-Agent: KMail/1.9.9
Cc:	David Daney <ddaney@caviumnetworks.com>, gregkh@suse.de,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
References: <4A00DA84.5040101@caviumnetworks.com> <20090603235428.GB19375@kroah.com>
In-Reply-To: <20090603235428.GB19375@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906040949.53167.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Thursday 04 June 2009 01:54:28 Greg KH, vous avez écrit :
> On Tue, May 05, 2009 at 05:32:04PM -0700, David Daney wrote:
> > This patch set introduces the octeon-ethernet driver into the
> > drivers/staging tree.  The Octeon is a mips64r2 base multi-core SOC
> > family.
> >
> > The first five patches are small tweaks to the existing octeon support
> > that are required by the ethernet driver.  I would expect them to be
> > merged via Ralf's linux-mips.org tree.
> >
> > The last two are the driver, and would probably be merged via the
> > drivers/staging tree.  However since they depend on the first five,
> > they probably shouldn't be merged until those five are merged.
>
> Ok, as Ralf doesn't seem to have responded to my previous query, I'll
> just merge the last driver, and mark it CONFIG_BROKEN which you can turn
> off when the infrastructure portions go in.
>
> Sound reasonable?

Cannot we get this driver merged via David Miller's tree instead ? It has been 
rock solid here and does not seem too ugly for a net-next-2.6 inclusion imho.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
