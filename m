Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 16:45:55 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34701 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993963AbdGKOpsGtMJz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jul 2017 16:45:48 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A70DAB43;
        Tue, 11 Jul 2017 14:45:47 +0000 (UTC)
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
To:     David Laight <David.Laight@ACULAB.COM>,
        'Gleb Fotengauer-Malinovskiy' <glebfm@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Valentin Rothberg <vrothberg@suse.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Slaby <jslaby@suse.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
 <063D6719AE5E284EB5DD2968C1650D6DD003758C@AcuExch.aculab.com>
From:   Aleksa Sarai <asarai@suse.de>
Message-ID: <a99e301b-05d1-d262-aca2-60e3f3400bc5@suse.de>
Date:   Wed, 12 Jul 2017 00:45:36 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD003758C@AcuExch.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <asarai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59096
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

>> Sent: 11 July 2017 01:12
>> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
>> because it doesn't copy anything from/to userspace to access the
>> argument.
>>
>> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
> ...
>> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
>> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
> 
> This is a user API change. When was the ioctl added?

It was just pulled this merge window (4.13-rc1).

  % git tag --contains 54ebbfb1603415d9953c150535850d30609ef077
  %

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
