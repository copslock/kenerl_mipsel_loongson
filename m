Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2016 18:05:55 +0100 (CET)
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36644 "EHLO
        mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010430AbcAMRFxMRwnV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jan 2016 18:05:53 +0100
Received: by mail-yk0-f180.google.com with SMTP id v14so402121258ykd.3
        for <linux-mips@linux-mips.org>; Wed, 13 Jan 2016 09:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VebqCV3n6ZzWzHoh98GKnZkM8x5Z3GlFI3aBaJBMFnI=;
        b=d28a0Zlp8jlaM46uF9iiKgki6WyVrau52AEkueEzoSYAGRaRaD3ihPMTwUNISaR7Pg
         kFNGxxnsfHpZFw+BWp76hdbiAWQGmtdQpPnh1qPoPbNRaFRF2VKIhSSHqhB0Y+BjR1s/
         Ck7aDSbK9DQNbPxcN69ptu7CxGRyZTGYpCIC+SEHSgshCmWy8FbRUl7mQbUIazDEgqUr
         1mKnJyB9xKvk/BulL7S5WTPWSODx685oNwjrkZ28xnS6D3794yTb+HyQuoYQI/r4B9d9
         EoXPERankOI2WPfJ/M8fL2sfFjzVEaCblYwPfwIMIoImYjstGZc+GpzvZflV7j3M1XGN
         J9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VebqCV3n6ZzWzHoh98GKnZkM8x5Z3GlFI3aBaJBMFnI=;
        b=WqHJadiX0gWdugqExa3Qs+teIKL20+TrIlxqrlLy1CYdA2S5xmOIscT+gu2BYEdki5
         5t4JeCthi6OdfDrF/Igj4TRvqUKQzFA2DzPBhvYiDUT5hbozJJzOjQay9C8+GsL5vr9K
         IQbzKwJbj5HGCNVgmsvk22oSD/k7Crtz26Y7XN9NFpQP6XaVnMgdhSPtuXVMDxZdBlyC
         nUx4stWvxgKQ7ZjIh6NM4U+4PLnc+/Vq5Q5NFOvRxpiv+HDtqJnr/2rdIrIGjWfa2ENQ
         1FvtEQEoTnDR4oh4cBKs9F7RjQ+Zbt9xd0WIbCUsQOxrwR6t35JRJQba0D9VVab2cpfj
         XOUQ==
X-Gm-Message-State: ALoCoQkzfJXKvd/g0Tqht9OYfCvGtE+1Pv/ffJSBEAw6scWANAdr7HC1b8R+l/AkHg1xH1sJXQeeRBEuDuiPZd6zZMlWGtiOfQ==
MIME-Version: 1.0
X-Received: by 10.13.218.196 with SMTP id c187mr17228139ywe.232.1452704745747;
 Wed, 13 Jan 2016 09:05:45 -0800 (PST)
Received: by 10.37.50.150 with HTTP; Wed, 13 Jan 2016 09:05:45 -0800 (PST)
X-Originating-IP: [212.159.75.221]
In-Reply-To: <1452189189-31188-1-git-send-email-mst@redhat.com>
References: <1452189189-31188-1-git-send-email-mst@redhat.com>
Date:   Wed, 13 Jan 2016 17:05:45 +0000
X-Google-Sender-Auth: 9a4mp0mGsj7VF7Fo4W2up5tL9Wg
Message-ID: <CAAG0J995iCNwdN6PpuJfzo+TVWNXR3UVqS9v-4HXbryyvMn+=w@mail.gmail.com>
Subject: Re: [PATCH] ld-version: fix it on Fedora
From:   James Hogan <james.hogan@imgtec.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Cc'ing Daniel, who has hit further breakage due to unusual version numbers.

On 7 January 2016 at 17:55, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fedora 23, ld --version outputs:
> GNU ld version 2.25-15.fc23
>
> But ld-version.sh fails to parse this, so e.g.  mips build fails to
> enable VDSO, printing a warning that binutils >= 2.24 is required.
>
> To fix, teach ld-version to parse this format.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Which tree should this be merged through? Mine? MIPS?
>
>  scripts/ld-version.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> index 198580d..25d23c8 100755
> --- a/scripts/ld-version.sh
> +++ b/scripts/ld-version.sh
> @@ -2,6 +2,8 @@
>  # extract linker version number from stdin and turn into single number
>         {
>         gsub(".*)", "");
> +       gsub(".*version ", "");
> +       gsub("-.*", "");
>         split($1,a, ".");
>         print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
>         exit
> --
> MST
>
