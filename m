Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 10:28:32 +0100 (CET)
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36021 "EHLO
        mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010546AbcBOJ2bHQ3S9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2016 10:28:31 +0100
Received: by mail-lb0-f193.google.com with SMTP id zr1so6066401lbb.3;
        Mon, 15 Feb 2016 01:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YmctZoC+b2OC2Ck6qUyi9QFHZpeo6+pV60mTLtp96FU=;
        b=ErQBOEW8jb42HYZ3FkBi/foDMi/67poGPX36M6Ggu3sc/4OoeiHWItRmum+fUsfSvy
         unBw+LcNd2i4SxZIeaxneIRaSv4lVz4rqrMUrmP3erDSvzloIsyLN2lq67oi10QmDEyI
         ySnMFCJnUp4gnkWP4JfP9MR6jMsBKc0j2R6l9eKPJIWCwBxuHylq+wlTYabwqsIxqIgH
         bS4JSePEZ/+paNAvLb1bO/xTLoUywn8OofgKvIZbbBkRdROXhyVcL9X63a9yRMPDAGIx
         ZruHgQWYV0kMJkXQYHDksCbsvD53j9OyjHSQijEcWd+zR1s5c2b/SKpu0kWykdpJsQZH
         0sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=YmctZoC+b2OC2Ck6qUyi9QFHZpeo6+pV60mTLtp96FU=;
        b=FxS5t1Sfu6FxH7emR4HBFXAT35EYp2HTr0nNtJGRhEjtZw2EIN93Mr7QP2WH/fqzAF
         hqrUTUbBmrusmBtVdZ3GiJ3P/eY1/mbvykJ3bk2zu/B4WI6rgiuRXf6hoJAiGfjFNnRA
         UXHhG9oha6rfwDa0gjgqYCb3s6bbSBrYLNorGkhkc6ff6gvajLR3CEtzNrq1OSiuDdVN
         iIlO23e+FFZ6/4XKo9w4ET0sYB1+nRllGxn64QajymkvHtkp6R5l1/wC1FlYcsE87vto
         YG8RSehmXN+NTk8M5YUhDewGvfYMh3yo64kSG3/snskY02o8WNV4ssWK3aoDBiP+eafM
         Gq6w==
X-Gm-Message-State: AG10YOTGN6NZPoUrFzX7nr3eNkAD2KIH0ViVbr8kQHev9Ckl5y5LdSvVVWgZVJ5vHTVPpQ==
X-Received: by 10.112.129.233 with SMTP id nz9mr6388288lbb.82.1455528505676;
        Mon, 15 Feb 2016 01:28:25 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id f202sm3537743lfg.12.2016.02.15.01.28.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Feb 2016 01:28:24 -0800 (PST)
Date:   Mon, 15 Feb 2016 12:54:08 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        devicetree@vger.kernel.org, David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 05/10] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop
 unused alias node
Message-Id: <20160215125408.8aa7386cf9ace5125fbb6579@gmail.com>
In-Reply-To: <56C0851D.5090105@denx.de>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
        <1455400697-29898-6-git-send-email-antonynpavlov@gmail.com>
        <56C0851D.5090105@denx.de>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Sun, 14 Feb 2016 14:46:05 +0100
Marek Vasut <marex@denx.de> wrote:

> On 02/13/2016 10:58 PM, Antony Pavlov wrote:
> > The TP-LINK TL-WR1043ND board has only one serial port,
> > so replacing the default of 0 with 0 does nothing useful.
> 
> I'd suggest to keep the aliases node, since it can be used by other
> non-Linux systems to access the serial port 0 . This might be useful in
> case you add some additional UART chip(s) too.
> 
> [...]

I have already submitted the patch which keeps the aliases node:

   https://www.linux-mips.org/archives/linux-mips/2016-01/msg00306.html


It was David Daney who proposed to drop unused aliases node:

   https://www.linux-mips.org/archives/linux-mips/2016-01/msg00353.html

-- 
Best regards,
  Antony Pavlov
