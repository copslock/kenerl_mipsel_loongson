Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 16:08:54 +0200 (CEST)
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34703 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025311AbcCaOIxC3Atm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Mar 2016 16:08:53 +0200
Received: by mail-lf0-f43.google.com with SMTP id c62so60476602lfc.1;
        Thu, 31 Mar 2016 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+1RQ16NFCihjbY6y7EiL+R7ApnsQBf0h9f6O7lM3Vw=;
        b=Q4e/SnIoAKQwZs9pxTwGf7YmvWIp4oyV+IwwwLd9QEyZEWmHqqggZRcZYbKRgxtvpV
         beLcMyoUtCMM9v86UGsdgnRp2K/uQK8fBoT4LRGtjVtzscVxqRRExbA9IN393KFhwNXy
         aHYJCpjMxxmOR2VeAxkoAsoSjTyMZqG6t60acAFhw+zJNckLmQLcTe2xG3M+vDcIqS8W
         lUG5+LqG0euExXB+H5zZdZZhsgRNY8gHngzBMCZooVtZlsn54dkjXrpbRIia6o9aHbIV
         J9GUn3wnbv3O7BLy3eHnFoTAwSeHWd1gJtkmhl6bKKNpM2ibtRNKzCCefZfRBJ5wj8SF
         VVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+1RQ16NFCihjbY6y7EiL+R7ApnsQBf0h9f6O7lM3Vw=;
        b=TCyO5bi+TevF90si2vcQLvQMWIeA3EqYuYVy6+XomrmD845knTXjNZRUV8ES774FZP
         7hkrPdzxnX0mY4Uv+IRfHFAPoujFZG1FqXqWuqE8K7xC/I1TQeJV7havql0vGFNmiBZA
         r8/GFScL+Vax5Ba9h6q88RtcC/LY5nIZXW9ZnW8LvqGZO82GJtyGPbppN8ooL+wC2TCi
         VmvcCgbQuM/U2fz1vOmj4LR+jP+XSQUhdjOPrWlLBhwbYJPHipJKXIkT4WgZM4Qa+6Em
         sm0cZbsTYvPQ3aXAqp0VsBgmedTKuSiJYy5BnA0YgR3TOUXgUWpmZD1Z5uR1ZjSEhRAH
         qqSA==
X-Gm-Message-State: AD7BkJKTGyVjwaTvS9ewluieK1sGhIImlrTvtlBU1d/rAY/eW304Xik+UWCO7XiR+O2AFA==
X-Received: by 10.25.20.222 with SMTP id 91mr7131658lfu.100.1459433327456;
        Thu, 31 Mar 2016 07:08:47 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id qh4sm1305193lbb.43.2016.03.31.07.08.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2016 07:08:46 -0700 (PDT)
Date:   Thu, 31 Mar 2016 17:08:31 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: fix build failure
Message-Id: <20160331170831.d775fe49863273c06177a4be@gmail.com>
In-Reply-To: <20160330215618.GB5275@linux-mips.org>
References: <1459351789-24544-1-git-send-email-sudipm.mukherjee@gmail.com>
        <20160330221329.25ca0849d782e55c0564f139@gmail.com>
        <20160330215618.GB5275@linux-mips.org>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52821
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

On Wed, 30 Mar 2016 23:56:18 +0200
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Mar 30, 2016 at 10:13:29PM +0300, Antony Pavlov wrote:
> 
> > It is very strange because my original patch has this closing brace.
> > Please see my original patch
> > https://www.linux-mips.org/archives/linux-mips/2016-03/msg00267.html
> 
> The patch didn't apply cleanly and I botched resolving it, sorry.  I folded
> the fix into the patch.
> 
> > Also I suppose that we have no need in detect_memory_region() if we use devicetree,
> > e.g.
> > 
> >                 ath79_detect_sys_type();
> >                 ath79_ddr_ctrl_init();
> >  +              detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
> >  +      }
> >   
> >  -      detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
> 
> "suppose" is a bit weak..  Should I move the detect_memory_region call?

I have just examined lastest master from git://git.linux-mips.org/pub/scm/ralf/linux

The problem is a bit more complex. We have to move _machine_restart assignment too.

I'll send fixup in a few seconds.

Also please remove a dot from commit title.

-- 
Best regards,
  Antony Pavlov
