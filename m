Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 16:16:00 +0100 (CET)
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35631 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011033AbcBKPP6Apblv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 16:15:58 +0100
Received: by mail-yw0-f179.google.com with SMTP id g127so41100807ywf.2;
        Thu, 11 Feb 2016 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y6hLgKBegrh4fqSyk7p0xyayszvFM7qJV6C+hjpkVuQ=;
        b=mJaEJEyrz9IiEbp4XOqoGwNQdNqpS8DtXlgyME2hKpsIl0aYOgiTSJfpQjXrBwJCDt
         803PUZ4JwVBPX4dmMkmYdrGZ4+GeqDZJisAJaCIkx5ElWMpkSO73bNj+G+UPVnBWFx96
         7/7upenB/texCLgTR5+APS3R30TlOFmqbGWaORlJ8M5pDzPfioQiB6/cNLdd4jnRMKga
         3iZvpRQHMWMH7ReH7akDRSHqVEkEvG1yh4UQEw0cPkQCnzYM5ZTYK/dldn2TA6tlqmwR
         qZDTR9ii3FrVkfN9ynscT4IZwF7TcrglnC0fMSVyhy8jXWdEYm/nO+3lX0oWM9FCdT1f
         RDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y6hLgKBegrh4fqSyk7p0xyayszvFM7qJV6C+hjpkVuQ=;
        b=GHdO3KOVpU6tzjRCy/nT9dvTpX6hdePSCvBY8G2RxwRqsyFojvIwQABIR4RW+OQmGt
         C0Q6umjkLupno7BSp1mOTSgbdZp0GnhdMbJ0kiID8S6sM2IBVQDEG63VnkU71KNQcCEw
         mwg3cjRkvcHQjrbQud16eKJ/Rfx5qEOYahTDbmJ1VU4Ix0lvdNLnwfOi5uzxTAYz5rtP
         VwXb57gEOazqDQq1SDHcBk7JFRjBnqM7VYDYYIhu+HNpTzhVUCHJYdUdNb0vH98CyFdn
         EfAaxATW3DDj5/g5JhHmc/CA38ORso1xOTeotQbZ/xlgMwcIY3Up5R6qXQQDqwXauMkT
         8+Ag==
X-Gm-Message-State: AG10YORnQfBiYgwmTIa1dXRppvpMtFz59J9+j/+VplgpdWw+QIizc44Q6zs87gCD7yPB7w==
X-Received: by 10.13.201.131 with SMTP id l125mr25851737ywd.150.1455203752186;
        Thu, 11 Feb 2016 07:15:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::8:abaa])
        by smtp.gmail.com with ESMTPSA id o23sm6680869ywd.30.2016.02.11.07.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2016 07:15:51 -0800 (PST)
Date:   Thu, 11 Feb 2016 10:15:51 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     hdegoede@redhat.com, david.daney@cavium.com,
        aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [Patch v9] SATA: OCTEON: support SATA on OCTEON platform
Message-ID: <20160211151551.GX3741@mtj.duckdns.org>
References: <1455198788-24754-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455198788-24754-1-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

On Thu, Feb 11, 2016 at 01:53:08PM +0000, Zubair Lutfullah Kakakhel wrote:
> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
> 
> The OCTEON SATA controller is currently found on cn71XX devices.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Applied to libata/for-4.6.

Thanks.

-- 
tejun
