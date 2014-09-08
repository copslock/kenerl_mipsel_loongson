Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 21:50:12 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:55916 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008488AbaIHTuJ5bsQ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Sep 2014 21:50:09 +0200
Received: from hanvin-mobl6.amr.corp.intel.com (jfdmzpr02-ext.jf.intel.com [134.134.137.71])
        (authenticated bits=0)
        by mail.zytor.com (8.14.7/8.14.5) with ESMTP id s88Jnwoq027932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 8 Sep 2014 12:49:58 -0700
Message-ID: <540E0860.2030600@zytor.com>
Date:   Mon, 08 Sep 2014 12:49:52 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v5 0/5] x86: two-phase syscall tracing and seccomp fastpath
References: <cover.1409954077.git.luto@amacapital.net> <CAGXu5jJpxzbpZfxXoBvDm6W-ogq3d5njRa2ir0text3evJT+QQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJpxzbpZfxXoBvDm6W-ogq3d5njRa2ir0text3evJT+QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

On 09/08/2014 12:29 PM, Kees Cook wrote:
> 
> As far as doing pulls, Peter, can you take the seccomp change from my
> tree as well? It makes sense to land all of this together.
> 

That is the plan.

	-hpa
