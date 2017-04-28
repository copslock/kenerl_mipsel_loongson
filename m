Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 21:55:59 +0200 (CEST)
Received: from mail-io0-x234.google.com ([IPv6:2607:f8b0:4001:c06::234]:36280
        "EHLO mail-io0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993942AbdD1TzuS9wLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 21:55:50 +0200
Received: by mail-io0-x234.google.com with SMTP id p80so75854680iop.3
        for <linux-mips@linux-mips.org>; Fri, 28 Apr 2017 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Bgk7i75TqlvnOHOuKQDJ/yA8CZykp5UyPyL5LVPb1/k=;
        b=1lbxjFBEnLTBIJ0YwwFu4/Rsh1KWsMua4KXkDrgc1GPytNKZL6xu3yZI3CSe77SfXJ
         BJXUlLNEEKJrU9bMlrYLpqn7HSy6jDwOpkZxlCooY8xIXcIoOUDT+/3smewKVCZehUnm
         4CI5OUpaTlTx7fFNrB/qOIHIJFIUumnHdwc5LH2ckYkNnkq8Yi4OM82wF3jesl3bXzOr
         8mnNbawulSKjq0QWC42yhu140EmY9ni+pX+6a3EhvaTc26+P39OLhfYnA1k2IE65hYvH
         ZpEtNINGfya7zJQO1R1GiuS0C+VDHHpTfwok6FB6OuDInehRPXs8PE6RzuM8VJiIWBNn
         Rzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Bgk7i75TqlvnOHOuKQDJ/yA8CZykp5UyPyL5LVPb1/k=;
        b=gNY8wt2V/0+uWCtcVXTuSalD5nx9m+oPetaUXLmpDDkG+zS00J6GnpESuD2sNMJ6sb
         wm/Y5J8KDBFXHw9XP4DVBkFFWRawK2t7ZAblJJ9QjfKwjRa6tptYL8Kbz/6js5XWrEYw
         AaoSYHS4XFE4a8FkNaFbp1KHhL5UVtwLOrC2WUDXQXzRrSMpU8BVHmgV6VruXOw2ZLKg
         s0tYUctNnjbKy6Xa33q5/zt/fZMs+FHGraU/XwyEP3NnrSK/EW12qOf74bKmL3nHcTsq
         Gnq1smU09jgrHHgEH8LdULblkFSDY81IVzsvHpZvaMe8cd24qBAYyglu+tefIh6rU8tU
         tDeQ==
X-Gm-Message-State: AN3rC/45OjH+W4un89jo3Wk3qWjoP3ciI2CP41FP4VTZOTfLazHtX2+z
        5uJy/h51yfp/PA==
X-Received: by 10.107.14.8 with SMTP id 8mr12151497ioo.46.1493409344372;
        Fri, 28 Apr 2017 12:55:44 -0700 (PDT)
Received: from [192.168.43.158] ([172.56.14.187])
        by smtp.googlemail.com with ESMTPSA id f37sm542160ioi.17.2017.04.28.12.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2017 12:55:43 -0700 (PDT)
Subject: Re: Commit 10b6ea0959de broke qemu reboot/exit.
To:     James Hogan <james.hogan@imgtec.com>
References: <bb1f5b37-26ca-10ff-c514-33899f21ea24@landley.net>
 <20170428083633.GL1105@jhogan-linux.le.imgtec.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        paul.burton@imgtec.com
From:   Rob Landley <rob@landley.net>
Message-ID: <96ebd0e6-944b-5df4-95ab-8db38f487ed8@landley.net>
Date:   Fri, 28 Apr 2017 14:55:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170428083633.GL1105@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 04/28/2017 03:36 AM, James Hogan wrote:
> CONFIG_POWER_RESET=y
> CONFIG_POWER_RESET_SYSCON=y

Yes, that was it. Thanks.

Rob
