Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 12:18:06 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:53780 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006685AbbK0LSEVZUP2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2015 12:18:04 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0M3OD6-1aK4u32jTM-00qwWf; Fri, 27 Nov
 2015 12:17:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: no-op delay loops
Date:   Fri, 27 Nov 2015 12:17:54 +0100
Message-ID: <3228673.rOyW85ILiP@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <87si3rbz6p.fsf@rasmusvillemoes.dk>
References: <87si3rbz6p.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:er2svJ9P867jsxOsErhvTzJKy+xwf8cSh9k8qdpId/+eWSPd/DE
 UZfe7JABPu0MyqiDV40uQHMBG/21CG48ij975ruvHMkg4Cs7Zh+rLOB9Y1gcnItObKICPtL
 QeW0+nBsVGgOrRY6wKCVhQKPYnTo47EmEqiZoCReVq6T03Hyk23sObgMkDlWf/zu+B+d/2P
 IMPX79pk3cw3GgIju+OqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aFvBpNDvaMM=:vPd/r1xcuYHZtsUDsuhObo
 8oKrUdAWIR7iu5WjBctbVz6DVR5U5ydW9oNIpA2La88qX858YJPSiKqYOkEIZwdXycpOgtC4A
 BtaFcthC5sG4XFZJn6HM/7/nYS5QMTgfVW+TO/WJtfyVFHqlPXC8R8BMssK1X05Wpumyxs7Rw
 ++7Xgzcw1EY1j4tEYAvzIhqnEdcV4ny2NPrqufhSffVVyN0Hil1kCZwSIzmPzmAjS8SXCc3Ay
 LqmJ39fjOqMRCu2vy4pDTiYjWJsdCPG0Tb99TZcJBtmzPslD4qoh5EGdoh53p8xVnzX74PzYp
 i5ZGCQyqdwsElQ9V6VIb/WDfXdl19Rx4b3+j5uVUaWhm1vdXZId367hOpI5EO2yUrDlOn/1Mi
 Ww8T3yiwWtKZa0w67FzuYKAdeApO11/hKD+LnSXu9OT0w4h37ylNKrUTjDEG1JQKMQyJ+T8/r
 X+iA/K/vXvcNj+1HpYcgZPJnTY64J578z/S7HIMpO6iRrPg4tl3L95EeDyolOZTO0HtbICh05
 s/CY5cOkLhdMUpdv9W8ykrD1vr+8reuL5aXLFaAgLjU6l7d9B+TiOUSyKFd9/fHVPBW0PSJ3Q
 OzyPH+EI7ctLtAxEHp+GQ88N9Elh+BpRlKoJE2VT3SF6NzsRYlqI/vGHSh8oppwN470KtCgsh
 yHTwCWvGO/lnbZ8F+JLmVIuBfcDkrux0PDoXImRY+76urCcv7+49h5b7Z93eDJSvSyMJ0zeTm
 YpQNw0cSOGJX9WIW
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Friday 27 November 2015 09:53:50 Rasmus Villemoes wrote:
> 
> It seems that gcc happily compiles
> 
> for (i = 0; i < 1000000000; ++i) ;
> 
> into simply
> 
> i = 1000000000;
> 
> (which is then usually eliminated as a dead store). At least at -O2, and
> when i is not declared volatile. So it would seem that the loops at
> 
> arch/mips/pci/pci-rt2880.c:235
> arch/mips/pmcs-msp71xx/msp_setup.c:80
> arch/mips/sni/reset.c:35
> 
> actually don't do anything. (In the middle one, i is 'register', but
> that doesn't change anything.) Is mips compiled with some special flags
> that would make gcc actually emit code for the above?
> 

I remember that gcc used to not optimize code that looked like a
delay loop such as the above, and my tests show that this was still
the case in gcc-4.0.3, but starting with gcc-4.1 it opimtized away
that loop.

	Arnd
