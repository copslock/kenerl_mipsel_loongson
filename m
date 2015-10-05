Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 12:11:42 +0200 (CEST)
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:58033 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009496AbbJEKLh3kGQ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 12:11:37 +0200
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-02v.sys.comcast.net with comcast
        id RNBY1r00157bBgG01NBYZY; Mon, 05 Oct 2015 10:11:32 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-po-13v.sys.comcast.net with comcast
        id RNBV1r0020w5D3801NBVDj; Mon, 05 Oct 2015 10:11:32 +0000
Subject: Re: Fwd: Re: [PATCH net-next 3/5] net: Refactor path selection in
 __ip_route_output_key
To:     David Ahern <dsa@cumulusnetworks.com>
References: <201510021431.hGNWKbMp%fengguang.wu@intel.com>
 <560EAAF3.3040509@cumulusnetworks.com>
Cc:     linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <56124CCE.1080703@gentoo.org>
Date:   Mon, 5 Oct 2015 06:11:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <560EAAF3.3040509@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1444039892;
        bh=CDSVuBX9jLVK4A6zenH9cyc4vXroR6z2bSrbvFrgVNc=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=XDyWtHX7bVuhbHkj24FxOrJd1VXXyuX+mmd9C4GP6hBy+RntitjmxJPl+pJ8QVXUd
         GsyUBJLkfPDWgVb48A+254UHJdfjj8UMnvkY4FiiviVdqo+9iynG6yNWPOuLHZTbji
         x0h/JdkZWzmv/xa1Ro3wmBp8RJAI3OOmXww7jR+jxroKVf0d/iycTxUnFtTRYLbnNU
         wvI6Bn3L40bhx/5lX1sk0A+Kj22I6nVQrJzPofr4k1YBgvrmdGcT2FNlrTUKed3BqG
         zGM3Sjv5jC5dJ3tPjddCXeZ/yHXTfgAjRTHf5IBurUucZ3IOL6p5t9SaBPXT4YX4Xf
         vNR8eczswOFEg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 10/02/2015 12:04, David Ahern wrote:
> Hello:
> 
> I could use some help understanding a message from a kbuild robot. I submitted
> this patch:
>     https://patchwork.ozlabs.org/patch/525102/
> 
> Which moves existing code into a function that is exported for modules. The
> kbuild robot found this warning:
> 
> -----
> 
> config: mips-nlm_xlp_defconfig (attached as .config)
> reproduce:
>         wget
> https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips
> 
> All warnings (new ones prefixed by >>):
> 
>>> mips-linux-gnu-ld: net/ipv4/.tmp_fib_semantics.o: warning: Inconsistent ISA
>>> between e_flags and .MIPS.abiflags
> 
> -----
> 
> I have no idea what that message means. I tried googling and found this recent
> thread:
>     http://www.linux-mips.org/archives/linux-mips/2015-05/msg00156.html
> and accompanying one:
>     https://sourceware.org/bugzilla/show_bug.cgi?id=18401
> 
> Can someone shed light on what the message means, why my patch generated the
> message and better yet how to fix it?
> 
> Thanks,
> David

Dunno if your patch generated the message per-say, but it seems some platforms
in the MIPS tree cause this message to appear. I.e., IP27 or IP32 builds (or
IP30 out-of-tree) don't emit this error, but building IP28 systems in-tree will
cause it to appear quite a bit.

The message itself, I believe is complaining that the stated CPU ISA (mips1 ...
mips4, mips32r2, r10000, etc) in one of the sections (e.g.,.MIPS.abiflags)
doesn't match the equivalent ISA value in the other section (e.g., e_flags). I
haven't seen any harmful side effects of it myself. Seems to be more of a
warning than anything else, and as long as the ISA matches a supported CPU
(e.g., r10000 is compatible with mips4), it can be ignored. It does clutter up
the build, though.

--J
