Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 17:14:16 +0200 (CEST)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:41784 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903850Ab2FZPOK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jun 2012 17:14:10 +0200
Received: by qcsd16 with SMTP id d16so11176qcs.28
        for <multiple recipients>; Tue, 26 Jun 2012 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/+VpWVTx9Iqrw12sjqLvAyYrM6tTXYM/EA2RtAXd1vI=;
        b=FMCrjj5LZ8WGir3Y9cXIoROpsJpEAW1hKfBZpnYA4U35VwxKbl7hV6oWEKQkR7BSDF
         5PpBNYOCw+R7IgdOB6EuWWanga1M1AKfJbXxQeRzt2Ki5yuxqV/vDlVzdI6ucKX5cfOJ
         ZjJXNgpvIoL5cp1ZvMM6wA/9J8P4viwpzlTES2p2QuXvd4rByFraGLq4/zM05tm8Vitk
         GdUbYl3U17Qwk00O2NQC2fSKWv0xbkat2+9i+Izwso2WGGcsVmfQf7jOAKXHBIW5qqUX
         d9+BWwphzI6VFqjNbe0zOeqTUcQPjoYtphlnhLBDlCZkHHeuF7IT1DJBk2e+oKXM0225
         Ixtw==
Received: by 10.182.119.6 with SMTP id kq6mr16814521obb.42.1340723644288; Tue,
 26 Jun 2012 08:14:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.98.195 with HTTP; Tue, 26 Jun 2012 08:13:44 -0700 (PDT)
In-Reply-To: <3c614d8672835e3950bddd7adbcecf05@localhost>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost> <3c614d8672835e3950bddd7adbcecf05@localhost>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 26 Jun 2012 17:13:44 +0200
Message-ID: <CAOiHx==iswg-BahEizXCu6iN4AAqJcTMXHouzKukO8mSm11i9g@mail.gmail.com>
Subject: Re: [PATCH 2/7] MIPS: BCM63XX: Move DMA descriptor definition into
 common header file
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     ralf@linux-mips.org, ffainelli@freebox.fr, mbizon@freebox.fr,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 33846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi Kevin,

On 23 June 2012 07:14, Kevin Cernekee <cernekee@gmail.com> wrote:
> The "IUDMA" engine used by bcm63xx_enet is also used by other blocks,
> such as the USB 2.0 device.  Move the definitions into a common file so
> that they do not need to be duplicated in each driver.

If it's common, maybe then it shouldn't be in bcm63xx_dev_enet.h but
something like bcm63xx_iudma.h, and the struct also renamed to
something generic (iudma_desc or so).

Regards,
Jonas
