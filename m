Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Mar 2013 19:48:02 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:56132 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827456Ab3CBSsCHVkdP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Mar 2013 19:48:02 +0100
Received: by mail-pb0-f51.google.com with SMTP id un15so2337082pbc.24
        for <linux-mips@linux-mips.org>; Sat, 02 Mar 2013 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/dSbBwUWOWf0bqffL/B41ncMCfndSPvxQ3JZiMFKfN8=;
        b=g+/fe5ly0Oc48yJbYvLRgCVWNVgwmvSDZaoC43HIO847h7N65lXgQDmcCEKhyLdoQH
         6IKUwMJvI2xew1btYKg5IgT5pPeh9pKkCpvJC90dV4eC4/CycW/+bS9u8aU9WTqZZTXw
         WSYCrWagxt9ZOaGpHzSjP7SF1JCxcdyi8g7Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=/dSbBwUWOWf0bqffL/B41ncMCfndSPvxQ3JZiMFKfN8=;
        b=gS++HcWTGV7502gNZf5vtwLG8TSNktmvGKiEWRaXbWKXe/1GrJy2zXsak+Zogq4Elm
         o55BbXjF/pItBR4ekWoNuWfnyaCIevXvh0tbLR5+8BS/U7h5JnMCxtgYJGXSGjgrsmoN
         zbL8anZu+Bl7FkHycz/VAIjSZAMMlVgSXcFRN/1achnCfuyHO5hy0cHqCvVgBLCcH+v+
         aK3svGXktF9SFpHphavwOJoK0K7lFlamn6anhQiKrN/34tW0DfJUVtBurduWPgWAcJBS
         47gNVx3xjebETdmq52bfoGq0YOMZLKrMYFzhulhoAXlHegpEiWDI4cUPg7l6dti1D0Cs
         K9Uw==
X-Received: by 10.66.221.67 with SMTP id qc3mr25269633pac.85.1362250075503;
        Sat, 02 Mar 2013 10:47:55 -0800 (PST)
Received: from localhost (67-148-102-249.dia.static.qwest.net. [67.148.102.249])
        by mx.google.com with ESMTPS id zv5sm15811362pab.2.2013.03.02.10.47.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 02 Mar 2013 10:47:54 -0800 (PST)
Date:   Sat, 2 Mar 2013 10:48:08 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ganesanr@broadcom.com
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Netlogic: Platform changes for XLR/XLS gmac
Message-ID: <20130302184808.GB2411@kroah.com>
References: <1362249374-25556-1-git-send-email-ganesanr@broadcom.com>
 <1362249374-25556-2-git-send-email-ganesanr@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1362249374-25556-2-git-send-email-ganesanr@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQm03H6EmU/Dhn6jStcuvJDfjXmPQiRbw2N+DkER+F2VxP2ynY8Dv3RIRKszdS00lZUScGkK
X-archive-position: 35836
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

On Sun, Mar 03, 2013 at 12:06:14AM +0530, ganesanr@broadcom.com wrote:
> From: Ganesan Ramalingam <ganesanr@broadcom.com>
> 
> Add platform code to create network interface (xlr-net) for XLR/XLS
> boards.
> 
> Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
> ---
>  This patch has be merged via linux-mips tree.
> 
>  This patch depends on [PATCH 1/2] Staging: Netlogic XLR/XLS GMAC driver.
> 
>  arch/mips/include/asm/netlogic/xlr/platform_net.h |   46 +++++
>  arch/mips/netlogic/xlr/Makefile                   |    3 +-
>  arch/mips/netlogic/xlr/fmn.c                      |    2 +
>  arch/mips/netlogic/xlr/platform_net.c             |  222 +++++++++++++++++++++
>  4 files changed, 272 insertions(+), 1 deletions(-)
>  create mode 100644 arch/mips/include/asm/netlogic/xlr/platform_net.h
>  create mode 100644 arch/mips/netlogic/xlr/platform_net.c

Staging drivers should be stand-alone, not depending on changes
elsewhere in the tree.  Why not either merge these into the staging
driver, or move the driver to the correct place to start with?

thanks,

greg k-h
