Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 11:33:29 +0200 (CEST)
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33714 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991104AbcJUJdW49HRj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 11:33:22 +0200
Received: by mail-lf0-f41.google.com with SMTP id x79so141706392lff.0
        for <linux-mips@linux-mips.org>; Fri, 21 Oct 2016 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vaxDvLghDv+SkmTSfcsxmaVK0QJOYjKgbKuZLXiKw34=;
        b=k4E19MzdWqjxmwg6NGYfmZ6ONysQ+fPnfxJhIlBg7XMN2x26j7KIkdoIbwxk1Ehc5Q
         yqJZoUA+Qf6IUrG9gYdkTfPrJrODUGrxMMHSMiMqqYgr65YI/niYxicZZVrIbUG6Cn/o
         /5c0GyPnHJrvx9EVwjdcKsnx8KJl8wId3DzI8JbBFw6LdhTJV6TwE39Cw4zDQ1/8wMqB
         4XFQLx/NrIM0SnBXvwd4BPHTqrTIbUy3We6qGTW9gvnS1Lp+HZ+g++kHH7llubZfkS1Z
         8s//DFrEADE2CJUy8YpjpSneA4uho7zHfruDbsIBv066wrDghlCGLVouRokf0STV8lt7
         hU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vaxDvLghDv+SkmTSfcsxmaVK0QJOYjKgbKuZLXiKw34=;
        b=Edv1L9wGP7/edCvugq+6oFA/J0zpJHlMH3wUN8lAnhzkDmMvsJQ9dQuEsWuPs+Yh0+
         jojLQWTl+eNVR60lfTqqPVeoFLeQAEZpE6uBdf/F7THbWIwvwX67MFIc9v3dnuzPGETC
         4UimnJIaMy2q5xqTq5GgB15TAEO+ZmiwQ8ZZya1OJkmQZZkLIhsFidEVfp7/HUG2yvEo
         ncDqwVd6IyPV16m0O0bxDjRWcRZjfXZOjqF1+ApSVUHmdy77yDuKsPLpTVuMndoX2uqp
         q0WEoUSEKcRqQ3io3vJcZ0saa97lAPF3djCdkRokO9Z8Ntg4wpj3a1ZtCr5UetnmoGyX
         q+bQ==
X-Gm-Message-State: AA6/9Rmy7mDMMvfDSPQ9+0J8TCtXKKhSvP9nVMgrxqJY1gokbnhl9febYWa47nulUEB9yg==
X-Received: by 10.25.40.74 with SMTP id o71mr6014687lfo.183.1477042396134;
        Fri, 21 Oct 2016 02:33:16 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.208])
        by smtp.gmail.com with ESMTPSA id y131sm296601lfd.26.2016.10.21.02.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Oct 2016 02:33:15 -0700 (PDT)
Subject: Re: [PATCH 1/6] kbuild: Keep device tree tables though dead code
 elimination
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
References: <20161020202705.3783-1-paul.burton@imgtec.com>
 <20161020202705.3783-2-paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Nicholas Piggin <npiggin@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a4baa8e5-a2e1-9020-dd81-a064e1f7bb81@cogentembedded.com>
Date:   Fri, 21 Oct 2016 12:33:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161020202705.3783-2-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

    s/though/through/ in the subject.

MBR, Sergei
