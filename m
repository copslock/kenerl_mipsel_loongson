Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2017 13:17:07 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:36408
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991339AbdGMLRALO0dL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jul 2017 13:17:00 +0200
Received: by mail-lf0-x244.google.com with SMTP id f28so5462795lfi.3
        for <linux-mips@linux-mips.org>; Thu, 13 Jul 2017 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDOcXtgYM9G3O4fI99ctDh24T/axgADhk4ZTNeBLORA=;
        b=kjMFtoXydEMYuDT9Qe5EhJ/lYhBdIDFOG/XtMzTrEf2TH6MQpYhcsZ6Jdg5CJcgEDo
         zhjcQdeWAT/Z2jMRI7TFfdZm4r0KiDvwvEAwVNiMP4NrIxk87iBADXG4RACRpnAQC7pC
         J8EVuQdSNexZEMMd8TaDaZzqfSq+eu9kFsOFEbKFc1pRniYXSLkcKCxofGTW3gtZdUI2
         2Xx54dlSZDHSSVscqh2UHGOpII9SR6TdIq8cgCK9k5CvnXCizBBvLp7AHXfyX7gDSwcy
         EeE7d11o19q9SSpIBzawifZ1L98fl7Nj1nvUXuj87EZ5vA+KkWpfrQWRreDo1x1XmWaF
         zB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDOcXtgYM9G3O4fI99ctDh24T/axgADhk4ZTNeBLORA=;
        b=ZDHnVIhAn9RrkpOD5FhtVmLJC9Z1NoRoJpo2JtEGFvgOG8S3LSSTDI1xkVjt9uKAOV
         UTgnpsPwZj77XmEm4Rn49Ow+uGIqgJbo2JH5K6dfkBuglUcEcn3aZk+WBbsLuwEZJhz0
         Sw7zJQAEH+h2JHvYz1NtssSWdKAkrWK+5F+kuSYHskjR+Mv/QhDxVjdtLlloR+DkyEwi
         hVV6eXD58j/TQfoY2xipQyhGg3qKyGUnJyKk3xHnLE094NPUDgWLL88g7k1y2ubikV9H
         UhkW1wMMvTJEtQZvq1M0Oea7hHqhgluHjIoXy3RtvXcO612UA6HePHsmjsBRBuqzI1+n
         xScw==
X-Gm-Message-State: AIVw111JbVOlmeOH3zhKbHBDDLgvRIvCleSlc9vKe3nrEKUWzqH+/fBE
        1pUVbAJ2xdMufg==
X-Received: by 10.25.228.17 with SMTP id b17mr1164780lfh.148.1499944614751;
        Thu, 13 Jul 2017 04:16:54 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id z18sm1097348lja.52.2017.07.13.04.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 04:16:53 -0700 (PDT)
Date:   Thu, 13 Jul 2017 14:27:09 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Oleksij Rempel <linux@rempel-privat.de>
Cc:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@openwrt.org>
Subject: Re: mainlining ar9344
Message-Id: <20170713142709.86e69aab7722424f7246050b@gmail.com>
In-Reply-To: <94279215-a561-58ec-db4b-94dfdd19f342@rempel-privat.de>
References: <94279215-a561-58ec-db4b-94dfdd19f342@rempel-privat.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.25; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59104
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

On Tue, 11 Jul 2017 22:40:04 +0200
Oleksij Rempel <linux@rempel-privat.de> wrote:

> Hallo all,
> 
> I have a bunch of ar9344 based APs and would like to spend some free
> time to make it work with mainline kernel (devicetree). Is it a good
> thing to do? Any one working on it?
> 

Alas! I have no AR9344-based boards for this at the moment.


-- 
Best regards,
  Antony Pavlov
