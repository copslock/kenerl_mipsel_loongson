Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 04:43:41 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:33468
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990428AbdKSDndkrsPF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 04:43:33 +0100
Received: by mail-pf0-x244.google.com with SMTP id a84so4821155pfl.0;
        Sat, 18 Nov 2017 19:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=caEm0XBgCPgdI2oENmWUsGaXt67qc5KQN7IrFijH2oA=;
        b=tnxQiCQc16Pe9tGHN2P4fA8DSjYlSuocwC4kB6LYkDZjeg+XhZtIhLo7w5HiVsiTDg
         vh4UiJP/JWuyuVgClNLiP8MHdJ/92HnGiFKNPQ14z4hDuO+dA/iCMOxUk+TmGeeyQnH4
         uVriIPlDaqFPsbpS8eGoc806+Gu12jTdOTL3bBpu7wQyuhHrHPFsiebSY2J3Xw/W7E2c
         iC5YuSh0t7nck7PkJpgVodASaaPQuAs0DjmD5MAtpHbsMRkhbdzhoKICaLpfNSgBL7wW
         zu5Bfws0CXRv5S+kNSSA7zuVmC20HUVOAAXej2gz3h9GUuaseifTjIg+wX5k4az9hLHc
         h76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=caEm0XBgCPgdI2oENmWUsGaXt67qc5KQN7IrFijH2oA=;
        b=kLvLAdddo9TPVYz0cnihzBemFNCLGZ0tviFzmdGAIZ1tI1pK8jqRzeILzUiPMA54iR
         PLiRRnGKm9C1velHOv14vpzWlZIv7JQsANCMHkZc8f0mQ6NulXupULkbLka25IJQYRWA
         XmAEISgQxJ9IBCeWkzUsrTLaHqhW8lG/viURfzszmvzqu3SzVdisv6U4a+DIuJHxIWsf
         vBo0rxAzTtvNpgDaPMBL5zc9GO0qXSuPqcVeTw+f/fObqTRbl6dJNTkCsOPOfxG8x73S
         L+uzdV4suXxrb8i3NVBAuuLJrUwsxt0CaN+XDJRnnE4yh1bI3pqqYvzFL8WU9UZ+PO0/
         YAyw==
X-Gm-Message-State: AJaThX6BXYl5AY2S/XNX3ebwMKNYT1j9LsoxQfv10j/hyYW2EqvgGGhj
        /tCAYuqWvxTSh4DVdwjxIzg=
X-Google-Smtp-Source: AGs4zMZHWEeSfCTlQhVnk8okv60lRMp3N2hcTv/YowoaZG+Hdupq0oP7UCIAtS2B2dvNAzNhhPcyBA==
X-Received: by 10.159.230.13 with SMTP id u13mr9857529plq.226.1511063007079;
        Sat, 18 Nov 2017 19:43:27 -0800 (PST)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k2sm12508401pff.126.2017.11.18.19.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 19:43:26 -0800 (PST)
Date:   Sat, 18 Nov 2017 19:43:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [22/26] MIPS: generic: Introduce generic DT-based board support
Message-ID: <20171119034325.GA17384@roeck-us.net>
References: <20160826153725.11629-23-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826153725.11629-23-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Aug 26, 2016 at 04:37:21PM +0100, Paul Burton wrote:
> Introduce a "generic" platform, which aims to be board-agnostic by
> making use of device trees passed by the boot protocol defined in the
> MIPS UHI (Universal Hosting Interface) specification. Provision is made
> for supporting boards which use a legacy boot protocol that can't be
> changed, but adding support for such boards or any others is left to
> followon patches.
> 
> Right now the built kernels expect to be loaded to 0x80100000, ie. in
> kseg0. This is fine for the vast majority of MIPS platforms, but
> nevertheless it would be good to remove this limitation in the future by
> mapping the kernel via the TLB such that it can be loaded anywhere & map
> itself appropriately.
> 
> Configuration is handled by dynamically generating configs using
> scripts/kconfig/merge_config.sh, somewhat similar to the way powerpc
> makes use of it. This allows for variations upon the configuration, eg.
> differing architecture revisions or subsets of driver support for
> differing boards, to be handled without having a large number of
> defconfig files.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Guess it is known that this patch causes failures when building
"allmodconfig" on test systems such as 0day; it was reported by 0day
some two months ago. nevertheless, the patch found its way into mainline
without fix. Does anyone care, or should I simply disable "allmodconfig"
test builds for mips ?

Guenter
