Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 16:23:44 +0200 (CEST)
Received: from smtp-out6.electric.net ([192.162.217.184]:65096 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993963AbdGKOXhijxAS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jul 2017 16:23:37 +0200
Received: from 1dUw4a-0005Wv-Vx by out6a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dUw4d-0005ms-T9; Tue, 11 Jul 2017 07:23:35 -0700
Received: by emcmailer; Tue, 11 Jul 2017 07:23:35 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out6a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1dUw4a-0005Wv-Vx; Tue, 11 Jul 2017 07:23:32 -0700
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Tue, 11 Jul 2017 15:23:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Gleb Fotengauer-Malinovskiy' <glebfm@altlinux.org>,
        Aleksa Sarai <asarai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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
Subject: RE: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Thread-Topic: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Thread-Index: AQHS+eU5TVOVgkfTM0KcxVD2Vg8Z7qJOrntA
Date:   Tue, 11 Jul 2017 14:23:29 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD003758C@AcuExch.aculab.com>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuExch.aculab.com
X-TLS:  TLSv1:AES128-SHA:128
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
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

From: Linuxppc-dev  Gleb Fotengauer-Malinovskiy
> Sent: 11 July 2017 01:12
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
> 
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
...
> -#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
> +#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */

This is a user API change. When was the ioctl added?

	David
