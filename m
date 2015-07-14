Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 19:13:36 +0200 (CEST)
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34630 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010567AbbGNRNcUcyXn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 19:13:32 +0200
Received: by qkcl188 with SMTP id l188so10859481qkc.1
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jSngEnxc6x0vZFsn2ueCboIvWuQvsHfzY8uuOn1pRqI=;
        b=GspA7tM1K7Qd6D/Q12vYmyql+l/JtssQeexdR/mDO5ODcur9rAr0gsB9A15GPqUToP
         NXBOSOo/Y31F1DeccrNaWAGAmh6ZdvTU5nb86pbXvLX+4EGQTi6HwQRWxBXPuAQhb0EK
         lvdTqMhntP8i/G604CHyMoyHldxv5jQN4kvP5vjHjQLlwRyno06cvlssnJ3pIiAlt2ar
         snwsGVjV+aVtfepVNA7uFeY8IY9rR4zJLTfPik88Y3Ep1YXcndOgeOPols5/hLaC8DV/
         VkKyi9ldLAODnaaK+Ljl3vsepfe3Mixy5cZWzAWlW0zIce6XtozwFv8C1w4EKUCuwDRA
         5Jwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jSngEnxc6x0vZFsn2ueCboIvWuQvsHfzY8uuOn1pRqI=;
        b=O8FSQ6iHu9hXQUEWQ1OR31v0lMN3fDrEHKuc+x8Pd4JnN1lD/NBJy8v8k5RT/fZmxu
         pf1Q4p50B+XTwqeoMTil1qepAgKehRCA2wmMuecYVqsl11yTNEv1SO+pcaPx+GnqcTCz
         Oj+lN2YAkewqaKbX5DhI0/v5Ki0YS8+kXA2kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jSngEnxc6x0vZFsn2ueCboIvWuQvsHfzY8uuOn1pRqI=;
        b=CEHfw+k1wNqpEZNFos0+IZ0yLJuEKVPRur+QeEWMEdARS5xtoNC+m638dreEGM0boh
         AgG6y7yOdXttzkJRsU/5R7finD5cOgafFBFX7g67QGqbMa61wMT+JRCDPEkam/c7HKev
         ebbqjsZNfk1X3axYhgExBguSu8BWtVvLlBL8ItJIjSDM+K8laktizFSs/aBTDFS82NPb
         syZraBOHA9iGjNHVPkid7GvMCvc5HLDdxLDeS+ByyNFXSGVWHU7wx5CRMiD1a8xO4z5D
         9GOT5qbYWXVzDlyOdMweX/0zz/oiZzIW+g6L9o/u1kOlsnJswBAiBebr6boGpGoNA3/a
         /iSw==
X-Gm-Message-State: ALoCoQlFy8S2lUNAhXnRkiPHEAZmQ/O787S8zLUIUvelcbivVblavKXEJCpcLi3YTB7u9skG2mIS
MIME-Version: 1.0
X-Received: by 10.140.81.40 with SMTP id e37mr25946223qgd.75.1436894006445;
 Tue, 14 Jul 2015 10:13:26 -0700 (PDT)
Received: by 10.140.19.98 with HTTP; Tue, 14 Jul 2015 10:13:26 -0700 (PDT)
In-Reply-To: <20150714164647.1541.42503.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
        <20150714164647.1541.42503.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date:   Tue, 14 Jul 2015 10:13:26 -0700
X-Google-Sender-Auth: UI2-Od8aJ59-K0FWGDVrWRAsbkI
Message-ID: <CAL1qeaFvRAqJ7pHkP-ELFV7b7BzxgnT=nUjv9Ae2WnSLBzw64g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] MIPS: Remove "weak" from get_c0_perfcount_int() declaration
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Hi Bjorn,

On Tue, Jul 14, 2015 at 9:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Weak header file declarations are error-prone because they make every
> definition weak, and the linker chooses one based on link order (see
> 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
> decl")).
>
> get_c0_perfcount_int() is defined in several files.  Every definition is
> weak, so I assume Kconfig prevents two or more from being included.  The
> callers contain identical default code used when get_c0_perfcount_int()
> isn't defined at all.
>
> Add a weak get_c0_perfcount_int() definition with the default code and
> remove the weak annotation from the declaration.
>
> Then the platform implementations will be strong and will override the weak
> default.  If multiple platforms are ever configured in, we'll get a link
> error instead of calling a random platform's implementation.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Andrew Bresticker <abrestic@chromium.org>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
