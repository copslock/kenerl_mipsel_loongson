Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 23:48:40 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:48000 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903669Ab2HNVsh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 23:48:37 +0200
Received: by ghbf20 with SMTP id f20so1094652ghb.36
        for <linux-mips@linux-mips.org>; Tue, 14 Aug 2012 14:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=JDuKt//y7zq54j+2pncaPIpkpiUQuoRtmDwP6xyph44=;
        b=g6NBAuYcEWkJPnTwUjbc7WcIkoid9pTTuA7RUaZGSuC43DX6e1+mR1dpIOzyc6cDEu
         z4Q6CD+AfAbXl/HjGVR1LhgNk7czgxY8Jbh7XvMtXj3o5MCQmNbgPS56SbRJW/cXjtiU
         7toMUMu9NBq8GRwLhWo5bbRRiRc0WdxwWbdpKxpRaD+kYLsN7f7F+uMmo0M5TywFAl3b
         0WMYWxYozTkoeiFFjT4VQfb7cJjN/8Ts51JwaSjABbU8rhMgciDWN4mM5hekhZEtOAS4
         54w7BawrEs8JFou23RqPgq2pfjz+BERJL+spxlMWQh0FoSOq0Rz7MnRkcOpjM5uGYHeu
         08RQ==
Received: by 10.50.216.202 with SMTP id os10mr12489790igc.7.1344980909902;
        Tue, 14 Aug 2012 14:48:29 -0700 (PDT)
Received: from localhost ([166.134.228.52])
        by mx.google.com with ESMTPS id 10sm604457igf.11.2012.08.14.14.47.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 14:48:28 -0700 (PDT)
Date:   Tue, 14 Aug 2012 14:46:55 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] MIPS: OCTEON: Fix breakage due to 8250 changes.
Message-ID: <20120814214655.GB19349@kroah.com>
References: <1344962559-6823-1-git-send-email-ddaney.cavm@gmail.com>
 <20120814165607.GA29888@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120814165607.GA29888@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQn5YOCXcKc4NrhBM8JVD2KV+7DEx2HaKOp7kjMzPBUqIWYeXjQVDhgMFih926xWOP+7pBtk
X-archive-position: 34171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Aug 14, 2012 at 06:56:07PM +0200, Ralf Baechle wrote:
> On Tue, Aug 14, 2012 at 09:42:39AM -0700, David Daney wrote:
> 
> > From: David Daney <david.daney@cavium.com>
> > 
> > The changes in linux-next removing serial8250_register_port() cause
> > OCTEON to fail to compile.
> > 
> > Lets make OCTEON use the new serial8250_register_8250_port() instead.
> 
> I think this one should go via the serial tree.
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Ok, I'll take it there, thanks.

greg k-h
