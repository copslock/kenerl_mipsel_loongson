Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2011 01:07:39 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:63341 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903626Ab1LGAHf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2011 01:07:35 +0100
Received: by ghrr19 with SMTP id r19so5954469ghr.36
        for <linux-mips@linux-mips.org>; Tue, 06 Dec 2011 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qUXhZZ21clLHrBg9tsR54TIRJUApuy5LN8/qaTBUNkA=;
        b=HQy0HgftZssyMC4n2MKTrDcK44Cnt0KsAQv/A4zefZxBkzUwhnZUde2wf95R9G25Yo
         B+vvVzK0ES1OXEQffEe6fR34au/+31LQvPm95D2+97b7+ZgwTR7GF9p1l4uk1fqUqjqx
         OseYrd8LQlIUu6jiI4L1tJQ+HULQIMBbmi5fw=
Received: by 10.236.200.201 with SMTP id z49mr23670917yhn.20.1323216449564;
        Tue, 06 Dec 2011 16:07:29 -0800 (PST)
Received: from bubble.grove.modra.org ([115.187.252.19])
        by mx.google.com with ESMTPS id f7sm6308120and.17.2011.12.06.16.07.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 16:07:28 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
        id 76718170C2BF; Wed,  7 Dec 2011 10:37:21 +1030 (CST)
Date:   Wed, 7 Dec 2011 10:37:21 +1030
From:   Alan Modra <amodra@gmail.com>
To:     David Daney <david.daney@cavium.com>,
        binutils <binutils@sourceware.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>,
        rdsandiford@googlemail.com
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
Message-ID: <20111207000721.GD21034@bubble.grove.modra.org>
Mail-Followup-To: David Daney <david.daney@cavium.com>,
        binutils <binutils@sourceware.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>,
        rdsandiford@googlemail.com
References: <4EDD669F.30207@cavium.com>
 <20111206054018.GB21034@bubble.grove.modra.org>
 <8762ht2yft.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8762ht2yft.fsf@firetop.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 32050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amodra@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5164

On Tue, Dec 06, 2011 at 09:16:22PM +0000, Richard Sandiford wrote:
> Showing my ignorance here, but is that the usual behaviour for this kind
> of thing?  I wouldn't have expected versions to apply to internally-created
> symbols.

Normally this sort of symbol isn't dynamic, at least nowadays.
Earlier versions of GNU ld made many symbols like
_GLOBAL_OFFSET_TABLE_ dynamic unnecessarily, so it might be just a
case of old mips code following even older practice.

-- 
Alan Modra
Australia Development Lab, IBM
