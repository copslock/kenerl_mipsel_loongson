Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Mar 2015 09:37:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57865 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006587AbbCSIhLAErRj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Mar 2015 09:37:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7C34469073BFF;
        Thu, 19 Mar 2015 08:37:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 19 Mar 2015 08:37:05 +0000
Received: from localhost (192.168.154.138) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 19 Mar
 2015 08:37:05 +0000
Date:   Thu, 19 Mar 2015 08:37:05 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Don Fry <pcnet32@frontier.com>
CC:     <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ethernet: pcnet32: Setup the SRAM and NOUFLO on
 Am79C97{3,5}
Message-ID: <20150319083704.GA31322@mchandras-linux.le.imgtec.org>
References: <1426709407-16033-1-git-send-email-markos.chandras@imgtec.com>
 <1426730854.1840.23.camel@Lunix2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1426730854.1840.23.camel@Lunix2.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.138]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Don,

On Wed, Mar 18, 2015 at 07:07:34PM -0700, Don Fry wrote:
> One little change to the comment is needed.  See below
> 
> Don
> 
> On Wed, 2015-03-18 at 20:10 +0000, Markos Chandras wrote:
> > +	if (sram) {
> > +		/*
> > +		 * The SRAM is being configured in two steps. First we
> > +		 * set the SRAM size in the BCR25:SRAM_SIZE bits. According
> > +		 * to the datasheet, each bit corresponds to a 512-byte
> > +		 * page so we can have at most 24 pages. The SRAM_SIZE
> > +		 * corresponds holds the value of the upper 8 bits of
> > +		 * the 16-bit SRAM size. The low 8-bits start at 0x00
> > +		 * and end at 0xff. So the address range is from 0x0000
> > +		 * up to 0x17ff. Therefore, the SRAM_SIZE is set to 0x17.
> > +		 * The next step is to set the BCR24:SRAM_BND midway through
> > +		 * so the Tx and Rx buffers can share the SRAM equally.
> > +		 */
> 
> The comment specifies BCR24 but the code is changing BCR26 which matches
> the documentation.  Please correct the comment to avoid confusion.
> 

Ah good catch. I will fix it and send a v2.

-- 
markos
