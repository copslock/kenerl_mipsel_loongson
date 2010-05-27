Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 20:24:17 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:52524 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492452Ab0E0SYN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 May 2010 20:24:13 +0200
Received: by gwj18 with SMTP id 18so262892gwj.36
        for <linux-mips@linux-mips.org>; Thu, 27 May 2010 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wJG5DrHUKD+W8GR3DpGQgiwsI4fl2w+eZR3rlgvjqJ4=;
        b=UY+zmaXbFP9WRejhMTE6ITe1/l6eyS5Y0GqZHycS+N14wfUyN70ciz2gV/64puY5lU
         Ujis0vDhiwinuOTlNZMNTTfd+iVGVkHVLlhO5zmi13r1Uuw1L+pwgT1CGtEc3Wd27qAV
         Us8vE91NRBKsY30Z9nNwvSuHcDs5A3+oDb79k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UR1ocN2CMQXDNxrZaSIz24wQ644kb7hxEIHBq0wFkkZoAqRdr0HSLVpvLNMcDJ9N/K
         MW3rRcPOSzRFox3rUN0rf2HEhdm8ZLf/UX0782QWfyUxH+l4AcwyymfqYs3PwCbsqcrV
         fCFEOE6Qpgy190jR7snfr/lys6ZSWmnkjzXeI=
MIME-Version: 1.0
Received: by 10.150.167.35 with SMTP id p35mr508139ybe.55.1274984647417; Thu, 
        27 May 2010 11:24:07 -0700 (PDT)
Received: by 10.150.158.2 with HTTP; Thu, 27 May 2010 11:24:07 -0700 (PDT)
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400DBBA5E5@XMB-RCD-208.cisco.com>
References: <7A9214B0DEB2074FBCA688B30B04400DBBA5E5@XMB-RCD-208.cisco.com>
Date:   Thu, 27 May 2010 11:24:07 -0700
Message-ID: <AANLkTikIqTozI-VK-U2iSoMjXGJLckZM2-N2xqIGRfBy@mail.gmail.com>
Subject: Re: [PATCH] Apply kmap_high_get with MIPS
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Dezhong Diao (dediao)" <dediao@cisco.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, May 3, 2010 at 4:40 PM, Dezhong Diao (dediao) <dediao@cisco.com> wrote:
> +               addr = (unsigned long)kmap_high_get(page);
> +               if (addr) {
> +                       addr += offset;
> +                       __dma_sync_virtual(addr, size, direction);
> +                       kunmap_high(page);
> +               }

When addr == 0, no flush is performed and that results in serious
coherency problems on my system.

The latest ARM code has a special "VIPT" handler for this case; I
suspect that MIPS needs something similar:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012169.html

My cache is VIPT with no aliases.
