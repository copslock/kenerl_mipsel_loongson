Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 12:25:03 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:59294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991948AbdFIKYkKtFtp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jun 2017 12:24:40 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A3D8AC2F;
        Fri,  9 Jun 2017 10:24:39 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] tty: add TIOCGPTPEER ioctl
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
References: <20170603141515.9529-1-asarai@suse.de>
 <20170603141515.9529-3-asarai@suse.de> <20170609092659.GA26933@kroah.com>
 <44c2b6c7-63ee-5c7f-cc77-5e1bcd69eea4@suse.de>
 <20170609100442.GA1405@kroah.com>
From:   Aleksa Sarai <asarai@suse.de>
Message-ID: <f3587aca-0d84-1ca7-cfb0-830e536410c2@suse.de>
Date:   Fri, 9 Jun 2017 20:24:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170609100442.GA1405@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <asarai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asarai@suse.de
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

>>>> When opening the slave end of a PTY, it is not possible for userspace to
>>>> safely ensure that /dev/pts/$num is actually a slave (in cases where the
>>>> mount namespace in which devpts was mounted is controlled by an
>>>> untrusted process). In addition, there are several unresolvable
>>>> race conditions if userspace were to attempt to detect attacks through
>>>> stat(2) and other similar methods [in addition it is not clear how
>>>> userspace could detect attacks involving FUSE].
>>>>
>>>> Resolve this by providing an interface for userpace to safely open the
>>>> "peer" end of a PTY file descriptor by using the dentry cached by
>>>> devpts. Since it is not possible to have an open master PTY without
>>>> having its slave exposed in /dev/pts this interface is safe. This
>>>> interface currently does not provide a way to get the master pty (since
>>>> it is not clear whether such an interface is safe or even useful).
>>>>
>>>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>>>> Cc: Valentin Rothberg <vrothberg@suse.com>
>>>> Signed-off-by: Aleksa Sarai <asarai@suse.de>
>>>
>>> Is this going to be documented anywhere?  Is there a man page update
>>> that also goes along with this?
>>
>> I will add one, I didn't know where the man-pages project is hosted / where
>> patches get pushed? What is the ML?
> 
>  From the MAINTAINERS file:
>    MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
>    M:      Michael Kerrisk <mtk.manpages@gmail.com>
>    W:      http://www.kernel.org/doc/man-pages
>    L:      linux-man@vger.kernel.org
>    S:      Maintained

Ah, should've looked there first!

Thanks Greg, I'll send it over the weekend.

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
