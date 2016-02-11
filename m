Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 01:56:38 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34789 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011509AbcBKA4gGat0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 01:56:36 +0100
Received: by mail-pa0-f48.google.com with SMTP id dk10so7097818pac.1
        for <linux-mips@linux-mips.org>; Wed, 10 Feb 2016 16:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lxsgdtic0MVknVGR9eAq33Agv+yUeEtJrJxuPtDKjSs=;
        b=rRuA+m0BtiLturYSMjZw5MKqPyyogQUUT8Z8c+3/Y0/xoTZ8T2E570sORlt7s8kkCk
         n12ouzgp3oJSoobhMqjd9d4UPUoEdAP7qkGVUa8g/hPHdsL0Ri+L3gZmdKjQrU487nx2
         otQVQDlO5F6UrwJ8B422ye5/0ycPJyZqSmdXQHFbL0IemSzf/F7wz4BWs7Skn7eDaXmO
         gRLbK6rdUdSJSChdDu2osUrxXlaK0XQcgiDHQv1qquchTe0kKyO/A7AjvciTDt6Fdb8P
         d5G51IMBxz0GgT7sclfi1iJN2CipymNefP1AIvCyzKMcgYlQA3tPYX8oZC+JBmTjaiuk
         rnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lxsgdtic0MVknVGR9eAq33Agv+yUeEtJrJxuPtDKjSs=;
        b=lwqPpNxqjXoVnaZ7I5cEDl0igDj9baTktYXrSXEdX6OuCT3u4xhDbb11hlrKztyB3m
         nLEqF15xfpQ2U0KuTG+zmuh0vYU2i+MjJMk4N5OoT8dyH73mMXNGq2XziGT4YbisjX7H
         fisIEgsxNPVOVWEQKht6vVQMx0xXA7meqt9fpe6sktbR34v6Y2iJ23W4pNZMLhRF8NIk
         4ZBBFDhmwZUlVnvqQPWf6mHGLz6GyjQ60l2nIxztH7zRrHaX2HG6OYCPWlzLBeVEpr1k
         87zFs0ch40S3b3y1Cd0B8w8NtvIyl9M3n4mUudiettcPo9hHEqvLD+8lqx9YX95rCbdS
         RxAA==
X-Gm-Message-State: AG10YOTo4zMRTOPHAYGxaJdDLfm7tKuC6eekvoLCqfiY94MmAafcij7njOXjYrW7jXOn7g==
X-Received: by 10.66.90.133 with SMTP id bw5mr62551439pab.22.1455152189927;
        Wed, 10 Feb 2016 16:56:29 -0800 (PST)
Received: from xeon-e3 (static-50-53-82-155.bvtn.or.frontiernet.net. [50.53.82.155])
        by smtp.gmail.com with ESMTPSA id h66sm7766081pfd.91.2016.02.10.16.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2016 16:56:29 -0800 (PST)
Date:   Wed, 10 Feb 2016 16:56:42 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     David Decotigny <ddecotig@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Subject: Re: [PATCH net-next v8 00/19] new ETHTOOL_GSETTINGS/SSETTINGS API
Message-ID: <20160210165642.6f8576d2@xeon-e3>
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <stephen@networkplumber.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stephen@networkplumber.org
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

On Tue,  9 Feb 2016 16:29:09 -0800
David Decotigny <ddecotig@gmail.com> wrote:

> Along the way, I chose to drop in the new structure the 3 ethtool_cmd
> fields marked "deprecated" (transceiver/maxrxpkt/maxtxpkt). They are
> still available for old drivers via the (old) ETHTOOL_GSET/SSET API,
> but are not available to drivers that switch to new API. Of those 3
> fields, ethtool_cmd::transceiver seems to be still actively used by
> several drivers, maybe we should not consider this field deprecated?
> The 2 other fields are basically not used. This transition requires
> some care in the way old and new ethtool talk to the kernel.

Please just fix old drivers. It is perfectly acceptable to break any
out of tree drivers.
