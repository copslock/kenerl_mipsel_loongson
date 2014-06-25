Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 15:05:35 +0200 (CEST)
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47751 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816417AbaFYNFdB0yuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 15:05:33 +0200
Received: from alan.etchedpixels.co.uk (proxy [81.2.110.250])
        by lxorguk.ukuu.org.uk (8.14.7/8.14.1) with ESMTP id s5PD2rdD016934;
        Wed, 25 Jun 2014 14:02:59 +0100
Date:   Wed, 25 Jun 2014 14:04:40 +0100
From:   One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8 1/1] man-pages: seccomp.2: document syscall
Message-ID: <20140625140440.6870eac1@alan.etchedpixels.co.uk>
In-Reply-To: <20140624205615.GW5412@outflux.net>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <20140624205615.GW5412@outflux.net>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnomes@lxorguk.ukuu.org.uk
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

On Tue, 24 Jun 2014 13:56:15 -0700
Kees Cook <keescook@chromium.org> wrote:

> Combines documentation from prctl, in-kernel seccomp_filter.txt and
> dropper.c, along with details specific to the new syscall.

What is the license on the example ? Probably you want to propogate the
minimal form of the text in seccomp/dropper into the document example to
avoid confusion ?

Alan
