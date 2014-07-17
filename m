Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 15:58:46 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:60561 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861336AbaGQN6mhYmHA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 15:58:42 +0200
Received: by mail-pa0-f51.google.com with SMTP id ey11so3384334pad.24
        for <multiple recipients>; Thu, 17 Jul 2014 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kbA9h4tZbt6HIGt1BFKIWN31rDHKEjpPEPYAkAZqzJk=;
        b=p5DfOyuHzFy/zLYngRZA8Fkc7SUgqxvvKEg2vpgGUTr1zXW1oxOxIgqNj99cl1lv8/
         9noP6pEUWDWOtpB0jyFlpkAGug/ql27mC8KM3abvaUVKptlPUtW+kx+8wqc8Pj3m7Lin
         do3V0/3AxlgQm+i2ni2Y7XPYOl84lXMBrvteZBdnc7gYiiOthC6u7vlYF0aKfuUrvHuA
         EGeoyd0qK0yWmZx84V7+C65n0qyP3hbv021hI54vB3Qj92aHDdg5Cs+Ax+lyKKVCKJdw
         s9uE3zQs7vtCvhM2/tmEDn7sPx1FxPeXLzKVf8z0cpCSNgakEt1vhFonkzLcSh+leZ8h
         HWvQ==
MIME-Version: 1.0
X-Received: by 10.67.16.67 with SMTP id fu3mr37331659pad.38.1405605515777;
 Thu, 17 Jul 2014 06:58:35 -0700 (PDT)
Received: by 10.70.40.167 with HTTP; Thu, 17 Jul 2014 06:58:35 -0700 (PDT)
In-Reply-To: <53C7D52E.5020205@imgtec.com>
References: <1405603655-12571-1-git-send-email-andrey.krieger.utkin@gmail.com>
        <53C7D52E.5020205@imgtec.com>
Date:   Thu, 17 Jul 2014 16:58:35 +0300
Message-ID: <CANZNk81DOOxYYFSKZMCh=uABd3ONB8wToTFc3_L_9TfyQDS1yQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arch/mips/net/bpf_jit.c: fix failure check
From:   Andrey Utkin <andrey.krieger.utkin@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        dborkman@redhat.com, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <andrey.krieger.utkin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrey.krieger.utkin@gmail.com
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

2014-07-17 16:52 GMT+03:00 Markos Chandras <Markos.Chandras@imgtec.com>:
> Thanks for the patch. I would personally prefer to use a new signed int
> variable, but I am fine either way.

If that's not a problem for performance etc., then i'll resubmit with
new temporary signed variable, because i believe it would be simpler
to comprehend.

-- 
Andrey Utkin
