Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 15:58:41 +0200 (CEST)
Received: from prod-mail-xrelay02.akamai.com ([72.246.2.14]:58170 "EHLO
        prod-mail-xrelay02.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012477AbbENN6kBCiMQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2015 15:58:40 +0200
Received: from prod-mail-xrelay02.akamai.com (localhost [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 95FA9286D7;
        Thu, 14 May 2015 13:58:35 +0000 (GMT)
Received: from prod-mail-relay06.akamai.com (prod-mail-relay06.akamai.com [172.17.120.126])
        by prod-mail-xrelay02.akamai.com (Postfix) with ESMTP id 7E9E7286D6;
        Thu, 14 May 2015 13:58:35 +0000 (GMT)
Received: from akamai.com (lappy-486.kendall.corp.akamai.com [172.28.12.253])
        by prod-mail-relay06.akamai.com (Postfix) with ESMTP id 787BB207E;
        Thu, 14 May 2015 13:58:35 +0000 (GMT)
Date:   Thu, 14 May 2015 09:58:35 -0400
From:   Eric B Munson <emunson@akamai.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow user to request memory to be locked on page
 fault
Message-ID: <20150514135835.GH1227@akamai.com>
References: <1431113626-19153-1-git-send-email-emunson@akamai.com>
 <20150508124203.6679b1d35ad9555425003929@linux-foundation.org>
 <20150511180631.GA1227@akamai.com>
 <20150513150036.GG1227@akamai.com>
 <20150514080812.GC6433@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
In-Reply-To: <20150514080812.GC6433@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
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


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2015, Michal Hocko wrote:

> On Wed 13-05-15 11:00:36, Eric B Munson wrote:
> > On Mon, 11 May 2015, Eric B Munson wrote:
> >=20
> > > On Fri, 08 May 2015, Andrew Morton wrote:
> > >=20
> > > > On Fri,  8 May 2015 15:33:43 -0400 Eric B Munson <emunson@akamai.co=
m> wrote:
> > > >=20
> > > > > mlock() allows a user to control page out of program memory, but =
this
> > > > > comes at the cost of faulting in the entire mapping when it is
> > > > > allocated.  For large mappings where the entire area is not neces=
sary
> > > > > this is not ideal.
> > > > >=20
> > > > > This series introduces new flags for mmap() and mlockall() that a=
llow a
> > > > > user to specify that the covered are should not be paged out, but=
 only
> > > > > after the memory has been used the first time.
> > > >=20
> > > > Please tell us much much more about the value of these changes: the=
 use
> > > > cases, the behavioural improvements and performance results which t=
he
> > > > patchset brings to those use cases, etc.
> > > >=20
> > >=20
> > > To illustrate the proposed use case I wrote a quick program that mmaps
> > > a 5GB file which is filled with random data and accesses 150,000 pages
> > > from that mapping.  Setup and processing were timed separately to
> > > illustrate the differences between the three tested approaches.  the
> > > setup portion is simply the call to mmap, the processing is the
> > > accessing of the various locations in  that mapping.  The following
> > > values are in milliseconds and are the averages of 20 runs each with a
> > > call to echo 3 > /proc/sys/vm/drop_caches between each run.
> > >=20
> > > The first mapping was made with MAP_PRIVATE | MAP_LOCKED as a baselin=
e:
> > > Startup average:    9476.506
> > > Processing average: 3.573
> > >=20
> > > The second mapping was simply MAP_PRIVATE but each page was passed to
> > > mlock() before being read:
> > > Startup average:    0.051
> > > Processing average: 721.859
> > >=20
> > > The final mapping was MAP_PRIVATE | MAP_LOCKONFAULT:
> > > Startup average:    0.084
> > > Processing average: 42.125
> > >=20
> >=20
> > Michal's suggestion of changing protections and locking in a signal
> > handler was better than the locking as needed, but still significantly
> > more work required than the LOCKONFAULT case.
> >=20
> > Startup average:    0.047
> > Processing average: 86.431
>=20
> Have you played with batching? Has it helped? Anyway it is to be
> expected that the overhead will be higher than a single mmap call. The
> question is whether you can live with it because adding a new semantic
> to mlock sounds trickier and MAP_LOCKED is tricky enough already...
>=20

The test code I have been using is a pathalogical test case that only
touches pages once and they are fairly far apart.

On the face batching sounds like a good idea, but I have a couple of
questions.  In order to batch fault in pages the seg fault handler needs
to know about the mapping in question.  Specifically it needs to know
where it ends so that it doesn't try and mprotect()/mlock() past the
end.  So now the program has to start tracking its maps in some globally
accessible structure and this sounds more like implementing memory
management in userspace.  How could this batching be implemented without
requiring the signal handler to know about mapping that is being
accessed?  Also, how much memory management policy is it reasonable to
expect user space to implement in these cases?

Eric


--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVKoLAAoJELbVsDOpoOa90wkQANW2KnooZXzzNUTsJw2B/QTN
YVIypMnzYWbm6PiOrXWmLEYy2WkkhZRFsFfrtj0qXNqj1JHI2l+ziyx0SEAeK6LZ
aN2/wL8E/uogVP0E8ti06hnkYdmq0AvwHujH3txHVK49wYl/q/X39tf2VxJBA1Ei
At3JVQ12OymEmzpsnttij1X6uTQQwzaXV/mgeNAk9TYxvj6IWmvkqhrvxBQQpfec
7yllbH2CWoWRxuhf+mc3R+LX2Vqz14nV0aWSDhIOSO+K+n5LVqBNrLKhKipnqPxQ
AID/yjBbZuXz/5RP+WddtFk1DwU25f9GyGzXhiq6tiLnayqmaL1vV61E1wkcsspA
CuS8+jmPcUJvNaiHP9126qTzTVybsz8vtJaZkNSM8Vp2RMrtQvODHuQYBBTClrqd
35PF/frytzOeEuqpP/Z0kwW/XnNGvcSC2wqM2Gmirn0QK7GsoEHqWRpvuFEcau1j
/beVWrq6anUmD5PB3RgWb58XP6Q5iQOFbNI8mHHnqZQg2RIMjujJ+f1pXt3bwVJ3
oZFLALVs9xvy5rDYyFnSVRs4iVEhn2tGdi/mW/oypHyfDsLHX+FhzSuvYCfocGq6
2jHlCcmQ1osDn8SXNf9bZpp0U0J18YRxV3fj2MHb8MDp9f7aaSr7oIrrZ2A/Zr6G
0b6iQjK20eFmcy4ranev
=Fok5
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
