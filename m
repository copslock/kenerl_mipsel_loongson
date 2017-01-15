Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2017 15:11:36 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:45961 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991346AbdAOOL2aIA0F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Jan 2017 15:11:28 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d3ce787c;
        Sun, 15 Jan 2017 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Hz1AOOBg+ufynV7zo9oKvejS2N8=; b=lkzTGN
        AL2V5i4JcEg+H/qXltFVzlYDC1/Ga/Z5ZxZ8qBYDz+cFtqWunbaz5yBno5QwtaRP
        r/YgkIRzisLm4rH8TofY2JqsUASrmRjWD9F8r+1m3q+bMMWga/CoJUsG4iChNFA9
        pXXMcU3KFWG1TyR7G0DeLkYft6rPGLcJDTug/T1ZmkX6Tk9y5ZYridCj+xe+Iv7Y
        Ldm6KwmXHXOdrgXKXOt8fraxktpEz2jigTXJVzywqsq0zMZ1+vaG7KxGJh5CcBY8
        80tTOhRHWmjLoN+CaOPao3Y84FXgc2WLojE7vSCp+Im5+3++eWSBiG14SX3MkeEG
        k0DUBxiOSa2MjsOQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6cebb205 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 15 Jan 2017 14:00:58 +0000 (UTC)
Received: by mail-ot0-f181.google.com with SMTP id f9so30453707otd.1;
        Sun, 15 Jan 2017 06:11:20 -0800 (PST)
X-Gm-Message-State: AIkVDXJWhq1rfAM0Mxwj6EXqU3OdWkcA1x1HGkXy4h3odB4A1Bo1HLhMHqFJ6ttsFdvLuc3SZG5B0P3xk5ZzgQ==
X-Received: by 10.157.54.136 with SMTP id h8mr4567789otc.240.1484489479762;
 Sun, 15 Jan 2017 06:11:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.14.167 with HTTP; Sun, 15 Jan 2017 06:11:19 -0800 (PST)
In-Reply-To: <20170115134848.GA27658@kroah.com>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
 <20170111012032.GE31072@linux-mips.org> <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
 <20170113094939.GI10569@jhogan-linux.le.imgtec.org> <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
 <20170115134848.GA27658@kroah.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 15 Jan 2017 15:11:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9q04CwkmorTJaGTWKS9gvJpOpyp4FGuhySKHC7CySDWHw@mail.gmail.com>
Message-ID: <CAHmME9q04CwkmorTJaGTWKS9gvJpOpyp4FGuhySKHC7CySDWHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] MIPS: Add per-cpu IRQ stack
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hi Greg,

On Sun, Jan 15, 2017 at 2:48 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> How many patches is the irqstacks "feature" for MIPS?  What kernel was
> it released in?  Have any git commit ids I can look at?

According to Ralf, it's queued up for 4.11? Is that right?

Part 1: https://lkml.org/lkml/2016/12/19/250
Part 2: https://lkml.org/lkml/2016/12/19/251
Part 3: https://lkml.org/lkml/2016/12/19/252
Part 4: https://lkml.org/lkml/2016/12/19/254
Part 5: https://lkml.org/lkml/2016/12/19/248

Jason
