Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 05:27:05 +0200 (CEST)
Received: from tundra.namei.org ([65.99.196.166]:54173 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859949AbaGRD1CddnZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Jul 2014 05:27:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id s6I3Qmxj015827;
        Fri, 18 Jul 2014 03:26:48 GMT
Date:   Fri, 18 Jul 2014 13:26:48 +1000 (EST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     linux-kernel@vger.kernel.org,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Drysdale <drysdale@google.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>, linux-api@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v12 11/11] seccomp: add thread sync ability
In-Reply-To: <1405620518-18495-1-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.11.1407181325200.15709@namei.org>
References: <1405620518-18495-1-git-send-email-keescook@chromium.org>
User-Agent: Alpine 2.11 (LRH 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jmorris@namei.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jmorris@namei.org
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

On Thu, 17 Jul 2014, Kees Cook wrote:

> Twelfth time's the charm! :)

Btw, there doesn't seem to be an official seccomp maintainer.  Kees, would 
you like to volunteer for this?  If so, send in a patch for MAINTAINERS, 
and set up a git tree for me to pull from.



-- 
James Morris
<jmorris@namei.org>
