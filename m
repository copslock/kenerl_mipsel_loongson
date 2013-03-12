Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 14:29:03 +0100 (CET)
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35670 "EHLO
        mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827485Ab3CLN3B6HHak (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Mar 2013 14:29:01 +0100
Received: by mail-pb0-f46.google.com with SMTP id uo15so4987904pbc.33
        for <linux-mips@linux-mips.org>; Tue, 12 Mar 2013 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5bwkHZ+NqKt7xUOz2bwDv3hJBPhxWgGuLNLPdqYhHmc=;
        b=CJSL22hYJymM1R7tFUF2XowAF6UzuN3xtJSPqEwIPD45/HPRQIPIGXZ/VCukWFEDO9
         JmLIqZOFeu/KCFyc1tueuHPWNnvu/SLI/w3fS/WwzVB8XWIRXDQOWeig+b3jzx4xrik0
         SSlOo8WzpFym/NvUp7oGbEg5f8LZ/w2S3WHM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=5bwkHZ+NqKt7xUOz2bwDv3hJBPhxWgGuLNLPdqYhHmc=;
        b=Seh/mSzF6Q3o/XmHZeQ2xVg4tv4LVqkuq6DzXQAikp0W9fiwkWcG3946hu3+3uXxev
         7TJmQBmBC284vU0SZAWmupGNTz1EnOlXY+k3EKwmx7iap/yxyOJZW+tBcZrbDNjxhMYT
         3X0J76XIZ/ESKpJ2VynElUnm7S/Z82OLQWBEnWd/brdYYm4ZAEIbhPX5clAHi3a7N1iC
         rEIKsUjK2fxW2/SryuLgiLF/DPPSO+DvtwAavLglo2idIgHGZRR6OIhMiO6tt9qSCIy2
         ht+/qtwQIlsDXZ8e8/n60K4PTuO9bm9ru7vOkFKTM3rv2cwxa1ZOELycomWxrupCyIrD
         3pvQ==
X-Received: by 10.68.12.103 with SMTP id x7mr37215638pbb.37.1363094935306;
        Tue, 12 Mar 2013 06:28:55 -0700 (PDT)
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net. [76.28.172.123])
        by mx.google.com with ESMTPS id ip8sm25058792pbc.39.2013.03.12.06.28.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:28:54 -0700 (PDT)
Date:   Tue, 12 Mar 2013 06:29:46 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Jim Quinlan <jim2101024@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix logic errors in bitops.c
Message-ID: <20130312132946.GA3467@kroah.com>
References: <1361918123-19404-1-git-send-email-ddaney.cavm@gmail.com>
 <20130312110718.GA6203@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130312110718.GA6203@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQmDULy+/Brvd9CjrJIUe/LxkU6PbkaT3aRwvQWthbCvX8ON3ahDeOTlUFNz6I1mVwZEXhmm
X-archive-position: 35878
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

On Tue, Mar 12, 2013 at 12:07:18PM +0100, Ralf Baechle wrote:
> On Tue, Feb 26, 2013 at 02:35:23PM -0800, David Daney wrote:
> 
> Applied.
> 
> -stable folks - this patch should be applied to 3.7-stable and 3.8-stable.

What patch?  What is the git commit id of it in Linus's tree?

And there is no 3.7-stable tree anymore, sorry, that kernel is
end-of-life now.

greg k-h
