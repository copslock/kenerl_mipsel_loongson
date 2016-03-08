Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 17:55:15 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:48132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008723AbcCHQzNiiuOr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Mar 2016 17:55:13 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id 4CCD17EBCA;
        Tue,  8 Mar 2016 16:55:06 +0000 (UTC)
Received: from redhat.com ([10.35.7.61])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u28Gt3eO021634;
        Tue, 8 Mar 2016 11:55:03 -0500
Date:   Tue, 8 Mar 2016 18:55:02 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Michal Marek <mmarek@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ld-version: Fix awk regex compile failure
Message-ID: <20160308185430-mutt-send-email-mst@redhat.com>
References: <1457455673-12219-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457455673-12219-1-git-send-email-james.hogan@imgtec.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

On Tue, Mar 08, 2016 at 04:47:53PM +0000, James Hogan wrote:
> The ld-version.sh script fails on some versions of awk with the
> following error, resulting in build failures for MIPS:
> 
> awk: scripts/ld-version.sh: line 4: regular expression compile failed (missing '(')
> 
> This is due to the regular expression ".*)", meant to strip off the
> beginning of the ld version string up to the close bracket, however
> brackets have a meaning in regular expressions, so lets escape it so
> that awk doesn't expect a corresponding open bracket.
> 
> Fixes: ccbef1674a15 ("Kbuild, lto: add ld-version and ld-ifversion ...")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Michal Marek <mmarek@suse.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 4.4.x-

Tested-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
> I've only tested this with GNU Awk 4.0.2, which seems a bit more
> lenient than whatever version of awk Geert's build machine is using.
> 
> I'd appreciated if somebody experiencing the error could give this patch
> a spin to check it fixes it.
> ---
>  scripts/ld-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> index d154f0877fd8..7bfe9fa1c8dc 100755
> --- a/scripts/ld-version.sh
> +++ b/scripts/ld-version.sh
> @@ -1,7 +1,7 @@
>  #!/usr/bin/awk -f
>  # extract linker version number from stdin and turn into single number
>  	{
> -	gsub(".*)", "");
> +	gsub(".*\\)", "");
>  	gsub(".*version ", "");
>  	gsub("-.*", "");
>  	split($1,a, ".");
> -- 
> 2.4.10
